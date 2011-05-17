#!/usr/bin/env ruby
#
# This file is gererated by ruby-glade-create-template 1.1.4.
#
require 'libglade2'

class TranspdfGlade
  include GetText

  attr :glade
  
  def initialize(path_or_data, root = nil, domain = nil, localedir = nil, flag = GladeXML::FILE)
    bindtextdomain(domain, localedir, nil, "UTF-8")
    @glade = GladeXML.new(path_or_data, root, domain, localedir, flag) {|handler| method(handler)}
    
  end
  
  def on_close_ok_clicked(widget)
    puts "on_close_ok_clicked() is not implemented yet."
  end
  def on_open_file_activate(widget)
    puts "on_open_file_activate() is not implemented yet."
  end
  def on_openB_clicked(widget)
    puts "on_openB_clicked() is not implemented yet."
  end
  def on_window1_delete_event(widget, arg0)
    puts "on_window1_delete_event() is not implemented yet."
  end
  def on_pdf_txt_button_release_event(widget, arg0)
    puts "on_pdf_txt_button_release_event() is not implemented yet."
  end
  def on_cancelB_clicked(widget)
    puts "on_cancelB_clicked() is not implemented yet."
  end
  def on_about_activate(widget)
    puts "on_about_activate() is not implemented yet."
  end
  def on_close_no_clicked(widget)
    puts "on_close_no_clicked() is not implemented yet."
  end
  def on_quit_tpdf_activate(widget)
    puts "on_quit_tpdf_activate() is not implemented yet."
  end
end

# Main program
if __FILE__ == $0
  # Set values as your own application. 
  PROG_PATH = "transpdf.glade"
  PROG_NAME = "YOUR_APPLICATION_NAME"
  TranspdfGlade.new(PROG_PATH, nil, PROG_NAME)
  Gtk.main
end
