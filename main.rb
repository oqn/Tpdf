#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
#
# This file is gererated by ruby-glade-create-template 1.1.4.
#
require 'rubygems'
require 'easy_translate'
require 'kconv'
require "transpdf"

$KCODE='s'



class Tpdf < TranspdfGlade  
  #include GetText

  #attr :glade
  
  def initialize(path_or_data, root = nil, domain = nil, localedir = nil, flag = GladeXML::FILE)
    super(path_or_data, root, domain, localedir, flag)
  end

  def on_window1_delete_event(widget, arg0)
    @glade["CloseDialog"].show_all
  end
  
  def on_close_ok_clicked(widget)
    Gtk.main_quit
  end
  
  def on_close_no_clicked(widget)
    @glade["CloseDialog"].hide
  end

  def on_open_file_activate(widget)

    filter = Gtk::FileFilter.new
    filter.name = "*.pdf"
    filter.add_pattern("*.pdf")
    @glade["FileChooserDialog"].add_filter(filter)
    
    filter = Gtk::FileFilter.new
    filter.name = "すべてのファイル"
    filter.add_pattern("*")
    @glade["FileChooserDialog"].add_filter(filter)
    @glade["FileChooserDialog"].filter = filter
    @glade["FileChooserDialog"].show_all
    begin
      @glade["FileChooserDialog"].current_folder = "/home/Tpdf"
    rescue
      p 
    end
  end

  def on_quit_tpdf_activate(widget)
    on_window1_delete_event(widget,false)
  end

  def on_openB_clicked(widget)
    fname = pdf2txt(@glade["FileChooserDialog"].filename)
    @glade["FileName"].text = File::basename(fname,".*")
    f = File.open(fname,"r")
    buff = Gtk::TextBuffer.new
    buff.set_text(f.read)
    @glade["pdf_txt"].buffer = buff  #f.readline 
    f.close
  end

  def pdf2txt(fname)
    result = `pdftotext #{fname}`
    @glade["FileChooserDialog"].hide
    dir, name = File::split(fname)
    return "#{dir}/#{File::basename(fname,".*")}.txt"
  end

  def on_cancelB_clicked(widget)
    @glade["FileChooserDialog"].hide
  end
end

def on_pdf_txt_button_release_event(widget,arg0)
  a = @glade["pdf_txt"].buffer.selection_bounds
  if a[0]!=a[1]
    str = @glade["pdf_txt"].buffer.get_slice(a[0],a[1],true)
    buff = Gtk::TextBuffer.new
    buff.set_text(EasyTranslate.translate(str, :to => :japanese))
    @glade["translated_txt"].buffer = buff
  end
  false
end


if __FILE__ == $0
  # Set values as your own application. 
  PROG_PATH = "transpdf.glade"
  PROG_NAME = "YOUR_APPLICATION_NAME"
  Tpdf.new(PROG_PATH, nil, PROG_NAME)
  Gtk.main
end
