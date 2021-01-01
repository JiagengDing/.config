# $pdf_mode=5

# use xelatex
$pdflatex = "xelatex -synctex=1 -interaction=nonstopmode";

#use skim
$pdf_previewer = 'open -a Skim';

@generated_exts = (@generated_exts, 'synctex.gz');

#clean and continue
# $cleanup_mode = 1;
$preview_continuous_mode = 1;
#@default_files = ('main.tex');

$out_dir = "latex.out";
