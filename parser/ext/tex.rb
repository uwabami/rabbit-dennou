#
# TeX コマンドの上書きとスタイルの追加
# $Id:$

# make_image_by_LaTeX を上書きする.
# 変更点は latex -> platex のみ

module Rabbit
  module Parser
    module Ext
      module TeX
        module_function
        def make_image_by_LaTeX(path, prop, logger)
          image_file = Tempfile.new("rabbit-image")
          latex_file = Tempfile.new("rabbit-image-latex")
          dir = File.dirname(latex_file.path)
          base = latex_file.path.sub(/\.[^.]+$/, '')
          dvi_path = "#{base}.dvi"
          eps_path = "#{base}.eps"
          log_path = "#{base}.log"
          aux_path = "#{base}.aux"
          File.open(path) do |f|
            src = []
            f.each_line do |line|
              src << line.chomp
            end
            latex_file.open
            latex_file.puts(make_latex_source(src.join("\n"), prop))
            latex_file.close
            begin
              latex_command = ["platex", "-halt-on-error",
                               "-output-directory=#{dir}", latex_file.path]
              dvips_command = ["dvips", "-q", "-E", dvi_path, "-o", eps_path]
              unless SystemRunner.run(*latex_command)
                raise TeXCanNotHandleError.new(latex_command.join(" "))
              end
              unless SystemRunner.run(*dvips_command)
                raise TeXCanNotHandleError.new(dvips_command.join(" "))
              end
              FileUtils.mv(eps_path, image_file.path)
              image_file
            ensure
              FileUtils.rm_f(dvi_path)
              FileUtils.rm_f(eps_path)
              FileUtils.rm_f(log_path)
              FileUtils.rm_f(aux_path)
            end
          end
        end

        # make_latex_source を追加する.
        # 変更点は
        # article -> jsarticle
        # txfonts, D6math を追加

        def make_latex_source(src, prop)
          latex = "\\documentclass[fleqn]{jsarticle}\n"
          latex << "\\usepackage[latin1]{inputenc}\n"
	  latex << "\\usepackage[varg]{txfonts}\n"
	  latex << "\\usepackage{D6math}\n"
          (prop["style"] || "").split.each do |style|
            latex << "\\usepackage[#{style}]\n"
          end
          latex << <<-PREAMBLE
\\begin{document}
\\thispagestyle{empty}
\\mathindent0cm
\\parindent0cm
PREAMBLE
          latex << src
          latex << "\n\\end{document}\n"
          latex
        end

      end
    end
  end
end
