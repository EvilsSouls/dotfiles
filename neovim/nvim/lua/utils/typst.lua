local MODE_INDICATORS = {
  'content',
  'string',
  'code',
  'math',
  'raw_span',
}

local M = {}

--- See https://github.com/tree-sitter/tree-sitter/discussions/3716
--- Somewhat plagiarised from https://github.com/nvim-treesitter/nvim-treesitter-context/blob/master/lua/treesitter-context/context.lua#L12
---@param bufnr integer? If equal to nil or zero the current buffer is searched
---@param pos [integer, integer]? If specified the location of the current node
---@param target_node TSNode? If specified the target node to get the ancestors of
--- @return TSNode[]?
--- @diagnostic disable-next-line
local function get_ancestors_curr_node(bufnr, pos, target_node)
  if bufnr == nil or bufnr == 0 then
    bufnr = vim.api.nvim_get_current_buf()
  end

  local tree = vim.treesitter.get_parser(bufnr):parse(nil)[1]
  local ret = {} --- @type TSNode[]

  if not tree then
    return
  end

  local p = tree:root() --- @type TSNode?

  if target_node == nil then
    if pos == nil then
      local win_id = vim.fn.bufwinid(bufnr)
      pos = vim.api.nvim_win_get_cursor(win_id)
      pos = { pos[1] - 1, pos[2] }

      if not pos then
        return
      end
    end

    target_node = vim.treesitter.get_node { bufnr = bufnr, pos = pos }
  end

  if not target_node then
    return
  end

  while p do
    ret[#ret + 1] = p
    --- @diagnostic disable-next-line:undefined-field added in 0.11
    p = p:child_with_descendant(target_node) --- @type TSNode?
  end

  return ret
end

---@param mode 'content' | 'string' | 'code' | 'math'
---@param bufnr integer? If equal to nil or zero the current buffer is searched
---@param pos [integer, integer]?
---@param ts_node TSNode?
---@return boolean
local function isInsideMode(mode, bufnr, pos, ts_node)
  local ancestors = get_ancestors_curr_node(bufnr, pos, ts_node)

  for i = #ancestors, 1, -1 do
    --- @diagnostic disable-next-line:need-check-nil
    local node_type = ancestors[i]:type()

    if node_type == mode then
      return true
    elseif require('utils.utils').array_includes(MODE_INDICATORS, node_type) then
      return false
    end
  end

  if not mode == 'content' then
    return false
  else
    return true
  end
end

---Check whether Treesitter Node is inside a Math node
---@param bufnr integer?
---@param pos [integer, integer]?
---@param ts_node TSNode?
---@return boolean
function M.isInsideMath(bufnr, pos, ts_node)
  return isInsideMode('math', bufnr, pos, ts_node)
end

---Check whether Treesitter Node is inside a Code node
---@param bufnr integer?
---@param pos [integer, integer]?
---@param ts_node TSNode?
---@return boolean
function M.isInsideCode(bufnr, pos, ts_node)
  return isInsideMode('code', bufnr, pos, ts_node)
end

---Check whether Treesitter Node is inside a Markup node
---@param bufnr integer?
---@param pos [integer, integer]?
---@param ts_node TSNode?
---@return boolean
function M.isInsideMarkup(bufnr, pos, ts_node)
  return isInsideMode('content', bufnr, pos, ts_node)
end

return M
