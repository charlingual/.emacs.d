  (autoload 'shell-toggle "shell-toggle-patched"
   "Toggles between the *shell* buffer and whatever buffer you are editing."
   t)
  (autoload 'shell-toggle-cd "shell-toggle-patched"
   "Pops up a shell-buffer and insert a \"cd <file-dir>\" command." t)
  (global-set-key "\C-ct" 'shell-toggle)
  (global-set-key "\C-cd" 'shell-toggle-cd)