-- Setup nvim-autopairs

local status_ok, npairs = pcall(require, "nvim-autopairs")
if not status_ok then
    return
end

-- Enable TreeSitter integration

npairs.setup {
    check_ts = true,
        ts_config = {
            lua = { "string" },
            javascript = { "string" },
            java = false
        }
}

-- Enable cmp integration

local cmp_npairs = require("nvim-autopairs.completion.cmp")
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

cmp.event:on(
  "confirm_done",
  cmp_npairs.on_confirm_done()
)
