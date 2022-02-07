local popup = require("plenary.popup")
local fn = vim.fn
local api = vim.api
function createFloatingWindow()
    local width = 60
    local height = 10
    local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
    local bufnr = api.nvim_create_buf(false, false)
    local Card_win_id, win = popup.create(bufnr, {
        title = "Card",
        highlight = "CardWindow",
        line = math.floor(((vim.o.lines - height) / 2) - 1),
        col = math.floor((vim.o.columns - width) / 2),
        minheight = height,
        minwidth = width,
        borderchars = borderchars,
    })

    api.nvim_win_set_option(
        win.border.win_id,
        "winhl",
        "Normal:CardBorder"
    )

    return {
        bufnr = bufnr,
        win_id = Card_win_id,
    }
end

local function close_card_menu()
    api.nvim_win_close(Card_win_id, true)
    Card_win_id = nil
    Card_bufh = nil
end

local function toggle_card()
    if Card_win_id ~= nil and api.nvim_win_is_valid(Card_win_id) then
        close_menu()
        return
    end

    -- if Card_win_id ~= nil then
    --     open_menu()
    --     return
    -- end

    local win_info = createFloatingWindow()
    local contents = {}
    -- contents[1] = card_id

    Card_win_id = win_info.win_id
    Card_bufh = win_info.bufnr

    api.nvim_win_set_option(Card_win_id, "number", true)
    api.nvim_buf_set_name(Card_bufh, "card_menu")
    api.nvim_buf_set_lines(Card_bufh, 0, #contents, false, contents)
    api.nvim_buf_set_option(Card_bufh, "filetype", "vimwiki")
    -- api.nvim_buf_set_option(Card_bufh, "buftype", "acwrite")
    api.nvim_buf_set_option(Card_bufh, "bufhidden", "delete")
    api.nvim_buf_set_keymap(
        Card_bufh,
        "n",
        "q",
        ":lua toggle_fwin()<CR>",
        { silent = true }
    )
end

-- local function createFloatingWindow()
--   local stats = api.nvim_list_uis()[1]
--   local width = stats.width
--   local height = stats.width
--   local bufh = api.nvim_create_buf(false, true)
--   local winId = api.nvim_open_win(bufh, true, {
--     relative="editor",
--     width = width - 4,
--     height = height - 4,
--     col = 2,
--     row = 2,
--   })
--   api.nvim_buf_set_lines(bufh, 0, -1, true, { "hello world", "heeeyyy" })
--   print("Window size:", height, width)
-- end

local function onResize()
  local stats = api.nvim_list_uis()[1]
  local width = stats.width
  local height = stats.width
  print("Window size:", height, width)
end

return {
  createFloatingWindow = createFloatingWindow,
  close_card_menu = close_card_menu,
  toggle_card = toggle_card,
  onResize = onResize
}

