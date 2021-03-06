{ lib, bundlerEnv, ruby
, withOptionalDependencies ? false
}:

# Bundix:
# nix-shell -p bundix zlib
bundlerEnv rec {
  name = pname + "-" + version;
  pname = "jekyll";
  version = (import
    (if withOptionalDependencies
      then ./full/gemset.nix
      else ./basic/gemset.nix))
    .jekyll.version;

  inherit ruby;
  gemdir = if withOptionalDependencies
    then ./full
    else ./basic;

  meta = with lib; {
    description = "A blog-aware, static site generator, written in Ruby";
    longDescription = ''
      Jekyll is a simple, blog-aware, static site generator, written in Ruby.
      Think of it like a file-based CMS, without all the complexity. Jekyll
      takes your content, renders Markdown and Liquid templates, and spits out a
      complete, static website ready to be served by Apache, Nginx or another
      web server. Jekyll is the engine behind GitHub Pages, which you can use to
      host sites right from your GitHub repositories.
    '';
    homepage    = https://jekyllrb.com/;
    license     = licenses.mit;
    maintainers = with maintainers; [ primeos pesterhazy ];
    platforms   = platforms.unix;
  };
}
