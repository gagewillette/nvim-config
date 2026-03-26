require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

local function run_current_python_file()
  local filepath = vim.fn.expand "%:p"

  if filepath == "" then
    vim.notify("No file in current buffer", vim.log.levels.WARN)
    return
  end

  if vim.bo.filetype ~= "python" and filepath:sub(-3) ~= ".py" then
    vim.notify("Current buffer is not a Python file", vim.log.levels.WARN)
    return
  end

  local python_cmd = vim.fn.exepath "python" ~= "" and "python" or "python3"
  if vim.fn.exepath(python_cmd) == "" then
    vim.notify("Python executable not found in PATH", vim.log.levels.ERROR)
    return
  end

  vim.cmd "update"

  require("nvchad.term").runner {
    id = "pythonRunner",
    pos = "sp",
    clear_cmd = "clear; ",
    cmd = function()
      return python_cmd .. " " .. vim.fn.shellescape(filepath)
    end,
  }
end

map("n", "<leader>rr", run_current_python_file, { desc = "run current python file" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
