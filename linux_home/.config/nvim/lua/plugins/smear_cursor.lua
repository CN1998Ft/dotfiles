if true then
  return {}
end
return {
  "sphamba/smear-cursor.nvim",

  opts = {
    smear_between_buffers = true,
    smear_between_neighbor_lines = true,
    scroll_buffer_space = true,
    legacy_computing_symbols_support = false,
    smear_insert_mode = true,
    stiffness = 0.8,
    trialing_stiffness = 0.5,
    stiffness_insert_mode = 0.6,
    trialing_stiffness_insert_mode = 0.6,
    distance_stop_animating = 0.5,
  },
}
