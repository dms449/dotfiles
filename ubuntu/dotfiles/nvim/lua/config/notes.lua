-- Notes management for Neovim
-- Stores notes in ~/.notes directory as markdown files

local M = {}

-- Configuration
local notes_dir = vim.fn.expand("~/.notes")
local last_note_file = notes_dir .. "/.last_note"

-- Ensure notes directory exists
local function ensure_notes_dir()
	if vim.fn.isdirectory(notes_dir) == 0 then
		vim.fn.mkdir(notes_dir, "p")
	end
end

-- Get current timestamp for note naming
local function get_timestamp()
	return os.date("%Y-%m-%d_%H-%M-%S")
end

-- Save the last opened note path
local function save_last_note(note_path)
	local file = io.open(last_note_file, "w")
	if file then
		file:write(note_path)
		file:close()
	end
end

-- Get the last opened note path
local function get_last_note()
	local file = io.open(last_note_file, "r")
	if file then
		local path = file:read("*all"):gsub("%s+", "")
		file:close()
		if vim.fn.filereadable(path) == 1 then
			return path
		end
	end
	return nil
end

-- Open a note file and save it as last opened
local function open_note(note_path)
	vim.cmd("edit " .. note_path)
	save_last_note(note_path)
end

-- Create a new note with timestamp
function M.new_note(title)
	ensure_notes_dir()
	local timestamp = get_timestamp()
	local filename

	if title and title ~= "" then
		-- Sanitize title for filename
		local clean_title = title:gsub("[^%w%s%-_]", ""):gsub("%s+", "_")
		filename = timestamp .. "_" .. clean_title .. ".md"
	else
		filename = timestamp .. ".md"
	end

	local note_path = notes_dir .. "/" .. filename
	open_note(note_path)

	-- Add basic markdown header
	local lines = {
		"# " .. (title or "Note"),
		"",
		"Created: " .. os.date("%Y-%m-%d %H:%M:%S"),
		"",
		""
	}
	vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
	vim.api.nvim_win_set_cursor(0, { 5, 0 })
end

-- Open the last opened note
function M.open_last_note()
	local last_note = get_last_note()
	if last_note then
		open_note(last_note)
		print("Opened last note: " .. vim.fn.fnamemodify(last_note, ":t"))
	else
		print("No previous note found")
	end
end

-- List all notes using Telescope
function M.list_notes()
	ensure_notes_dir()

	-- Use a more reliable approach with fd or find
	local find_command
	if vim.fn.executable('fd') == 1 then
		find_command = { "fd", "--type", "f", "--extension", "md", ".", notes_dir }
	elseif vim.fn.executable('find') == 1 then
		find_command = { "find", notes_dir, "-type", "f", "-name", "*.md" }
	else
		-- Fallback: let Telescope handle it
		find_command = nil
	end

	local opts = {
		prompt_title = "Notes",
		cwd = notes_dir,
		hidden = true,
		follow = true,
		attach_mappings = function(prompt_bufnr, map)
			local actions = require('telescope.actions')
			local action_state = require('telescope.actions.state')

			map('i', '<CR>', function()
				local selection = action_state.get_selected_entry()
				actions.close(prompt_bufnr)
				if selection then
					local full_path = selection.path or selection.value
					-- Ensure we have the full path
					if full_path and not full_path:match("^/") then
						full_path = notes_dir .. "/" .. full_path
					end
					if full_path then
						open_note(full_path)
					end
				end
			end)

			return true
		end,
	}

	if find_command then
		opts.find_command = find_command
	end

	require('telescope.builtin').find_files(opts)
end

-- Search notes by content using Telescope live_grep
function M.search_notes(query)
	ensure_notes_dir()
	local opts = {
		prompt_title = "Search Notes Content",
		cwd = notes_dir,
		search_dirs = { notes_dir },
		attach_mappings = function(prompt_bufnr, map)
			local actions = require('telescope.actions')
			local action_state = require('telescope.actions.state')

			map('i', '<CR>', function()
				local selection = action_state.get_selected_entry()
				actions.close(prompt_bufnr)
				if selection then
					open_note(selection.filename)
					-- Jump to the line with the match
					vim.api.nvim_win_set_cursor(0, { selection.lnum, selection.col - 1 })
				end
			end)

			return true
		end,
	}

	if query and query ~= "" then
		opts.default_text = query
	end

	require('telescope.builtin').live_grep(opts)
end

-- Setup commands
function M.setup()
	-- Create user commands
	vim.api.nvim_create_user_command("NotesNew", function(opts)
		M.new_note(opts.args)
	end, { nargs = "?", desc = "Create a new note" })

	vim.api.nvim_create_user_command("NotesLast", function()
		M.open_last_note()
	end, { desc = "Open the last opened note" })

	vim.api.nvim_create_user_command("NotesList", function()
		M.list_notes()
	end, { desc = "List all notes with Telescope" })

	vim.api.nvim_create_user_command("NotesSearch", function(opts)
		M.search_notes(opts.args)
	end, { nargs = "?", desc = "Search notes by content with Telescope" })



	-- Shorter aliases
	vim.keymap.set("n", "<leader>nn", function()
		M.new_note()
	end, { desc = "Create a new note (alias)" })

	-- Keybindings
	vim.keymap.set('n', '<leader>fn', function()
		M.search_notes()
	end, { desc = "Search notes content" })

	vim.keymap.set('n', '<leader>ln', function()
		M.list_notes()
	end, { desc = "Open notes directory" })
end

return M
