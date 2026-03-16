dbreset() {
    sudo -u postgres psql -d samwise_local_database -c "DROP SCHEMA IF EXISTS drizzle, public CASCADE; CREATE SCHEMA public; GRANT ALL ON SCHEMA public TO postgres, samwise_local_user;"
}

lambda() {
    if [ -z "$1" ]; then
        echo "Usage: lambda <function-name>"
        return 1
    fi

    aws lambda invoke --profile samwise-aws-nonprod --region us-east-1 --payload {} --function-name "$1" response.json
}

migrate-demo() {
    lambda samwise-psm-staging-dbmigrateFunction-bcucvrum
}

migrate-prod() {
    lambda samwise-psm-production-dbmigrateFunction-vecwfrrv
}

# Start an SST dev session, killing any existing SST processes first.
# This handles multiple git worktrees by detecting processes running in
# any worktree of the same repository, not just the current directory.
sam() {
    # Extract project name from sst.config.ts
    local PROJECT_NAME=$(grep "name:" sst.config.ts | head -1 | awk -F"'" '{print $2}')

    if [ -z "$PROJECT_NAME" ]; then
        echo "Error: Could not extract project name from sst.config.ts"
        return 1
    fi

    # Get the main git directory (works from any worktree)
    local GIT_COMMON_DIR=$(git rev-parse --git-common-dir 2>/dev/null)

    if [ -z "$GIT_COMMON_DIR" ]; then
        echo "Error: Not in a git repository"
        return 1
    fi

    # Get the root of the main repo (parent of .git)
    local MAIN_REPO_ROOT=$(dirname "$GIT_COMMON_DIR")

    echo "Cleaning up existing SST sessions for '$PROJECT_NAME'..."

    # Find and kill sst dev processes for this project (any worktree)
    local PIDS=$(pgrep -f "sst.*dev" 2>/dev/null | while read pid; do
        # Check if this process is related to the main repo or any of its worktrees
        if lsof -p "$pid" 2>/dev/null | grep -qE "$MAIN_REPO_ROOT|\.git/worktrees"; then
            echo "$pid"
        fi
    done)

    if [ -n "$PIDS" ]; then
        echo "Killing existing SST processes: $PIDS"
        echo "$PIDS" | xargs kill -9 2>/dev/null || true
        sleep 1
    else
        echo "No existing SST sessions found."
    fi

    echo "Starting new dev session..."
    exec bun sst dev
}

