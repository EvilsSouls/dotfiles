local M = {}

---Iterate through an array-like table to check whether it includes the specified value.
---@param arr table The array-like table to search
---@param val any The value to search for
---@return boolean
function M.array_includes(arr, val)
  for i=1,#arr do
    if arr[i] == val then
      return true
    end
  end

  return false
end

---Shamefully copied from http://lua-users.org/wiki/SplitJoin
---(under heading 'Function: Split a string with a pattern, Take Three')
---@param str string The string to split
---@param delim string A pattern specifying the delimiter
---@param maxNb integer? Maximum number of substrings returned
---@return table substrs An array-like table that contains all of the split substrings
function M.split_str(str, delim, maxNb)
   -- Eliminate bad cases...
   if string.find(str, delim) == nil then
      return { str }
   end
   if maxNb == nil or maxNb < 1 then
      maxNb = 0    -- No limit
   end
   local result = {}
   local pat = "(.-)" .. delim .. "()"
   local nb = 0
   local lastPos
   for part, pos in string.gfind(str, pat) do
      nb = nb + 1
      result[nb] = part
      lastPos = pos
      if nb == maxNb then
         break
      end
   end
   -- Handle the last field
   if nb ~= maxNb then
      result[nb + 1] = string.sub(str, lastPos)
   end
   return result
end

return M
