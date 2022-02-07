fun! WikiFlash()
  lua for k in pairs(package.loaded) do if k:match("^wiki%-flash%") then package.loaded[k] = nil end end
  lua require("wiki-flash").createFloatingWindow()
endfun
augroup WikiFlash
  autocmd!
  autocmd VimResized * :lua require("wiki-flash").onResize()
augroup END

