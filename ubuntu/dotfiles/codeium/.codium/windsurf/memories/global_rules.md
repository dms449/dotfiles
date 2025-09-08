# general programming guidlines

- never put comments unless told to

## for Vue.js

- always use Vue 3 Composition API
- use defineModel and don't import it instead of using the props / emits with modelValue
- any call to useMutation or useQuery is referencing something local, not the vue/apollo one.

## for Javascript

- prefer the function keyword over arrow functions
