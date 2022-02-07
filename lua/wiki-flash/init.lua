local fn = vim.fn
local api = vim.api
local function createFloatingWindow()
  local stats = api.nvim_list_uis()[1]
  local width = stats.width
  local height = stats.width
  local bufh = api.nvim_create_buf(false, true)
  local winId = api.nvim_open_win(bufh, true, {
    relative="editor",
    width = width - 4,
    height = height - 4,
    col = 2,
    row = 2,
  })
  api.nvim_buf_set_lines(bufh, 0, -1, true, { "hello world", "heeeyyy" })
  print("Window size:", height, width)
end

local function onResize()
  local stats = api.nvim_list_uis()[1]
  local width = stats.width
  local height = stats.width
  print("Window size:", height, width)
end

return {
  createFloatingWindow = createFloatingWindow,
  onResize = onResize
}

