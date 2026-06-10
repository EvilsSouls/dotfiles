function msp -w "uv run manim-slides present"
  uv run manim-slides render -- -qh $argv
  uv run manim-slides present
end
