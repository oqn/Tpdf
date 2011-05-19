#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
#
# This file is gererated by ruby-glade-create-template 1.1.4.
#
require 'rubygems'
require 'easy_translate'
require 'kconv'
require "transpdf"
require "data"

$KCODE='s'



class Tpdf < TranspdfGlade  
  #include GetText

  #attr :glade
  
  def initialize(path_or_data, root = nil, domain = nil, localedir = nil, flag = GladeXML::FILE)
    super(path_or_data, root, domain, localedir, flag)

    @filename = nil
    @logfile = DataFile.new

    add_accel_keys
  end

  def add_accel_keys
    ag = Gtk::AccelGroup.new
    ag.connect(Gdk::Keyval::GDK_M, Gdk::Window::CONTROL_MASK, Gtk::ACCEL_VISIBLE){ 
      @glade["myspace"].set_focus(true)
    }
    ag.connect(Gdk::Keyval::GDK_I, Gdk::Window::CONTROL_MASK, Gtk::ACCEL_VISIBLE){ 
      trans = "|英|\"" + @glade["translated_txt"].buffer.text + "\"\n"

      a = @glade["pdf_txt"].buffer.selection_bounds
      str = "|日|\"" + @glade["pdf_txt"].buffer.get_slice(a[0],a[1],true) + "\"\n"
      @glade["myspace"].buffer.insert_at_cursor(trans + str)
    }

    @glade["window1"].add_accel_group(ag)
  end

  #メインウィンドウの閉じるボタンを押したときに呼び出されるシグナル。
  #Tpdfを終了するかどうかの確認ダイアログを表示する。
  def on_window1_delete_event(widget, arg0)
    @glade["CloseDialog"].show_all
  end

  #メインウィンドウを閉じる際の確認ダイアログで"OK"を押したとき呼び出されるシグナル。
  #Tpdfを終了する。
  #PDFのテキストとメモをYAML形式で保存
  def on_close_ok_clicked(widget)
    @logfile.set_txt(@glade["pdf_txt"].buffer.text)
    @logfile.set_memo(@glade["myspace"].buffer.text)
    @logfile.to_yaml(@glade["FileName"].text)
    if File.exist?("#{@glade["FileName"].text}.txt")
      File.delete("#{@glade["FileName"].text}.txt")
    end
    Gtk.main_quit
  end

  #メインウィンドウを閉じる際の確認ダイアログで"NO"を押したとき呼び出されるシグナル。
  #Tpdfを閉じない。
  def on_close_no_clicked(widget)
    @glade["CloseDialog"].hide
  end

  #メニューバーの[ファイル]->[開く]で呼び出されるシグナル。
  #ファイル選択ダイアログが表示される。
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
      @glade["FileChooserDialog"].current_folder = "~/Tpdf"
    rescue
      @glade["FileChooserDialog"].current_folder = "~/"
    end
  end

  #メニューバーの[ファイル]->[終了]で呼び出されるシグナル。
  #メインウィンドウの閉じるボタンを押したときに呼び出されるシグナルを呼ぶ。
  def on_quit_tpdf_activate(widget)
    on_window1_delete_event(widget,false)
  end

  #ファイル選択ダイアログで開くボタンを押したときに呼び出されるシグナル。
  #pdf2txtシグナルをよび、PDFファイルと同じ名前のテキストファイルを生成し、
  #テキストビューで表示する。
  def on_openB_clicked(widget)
    begin
      fname = @glade["FileChooserDialog"].filename
      dir, name = File::split(fname)
      @glade["FileName"].text = "#{dir}/#{File::basename(fname,".*")}"
      buff1 = Gtk::TextBuffer.new
      buff2 = Gtk::TextBuffer.new
      if File.exist?("#{@glade["FileName"].text}.yaml")
        @logfile.read_yaml("#{@glade["FileName"].text}.yaml")
        buff1.set_text(@logfile.get_txt)
        @glade["pdf_txt"].buffer = buff1
        buff2.set_text(@logfile.get_memo)
        @glade["myspace"].buffer = buff2
      else
        textname = pdf2txt(fname)
        f = File.open(textname,"r")
        buff = Gtk::TextBuffer.new
        buff1.set_text(f.read)
        @glade["pdf_txt"].buffer = buff1
        f.close
        @filename = textname
      end
    ensure
      @glade["FileChooserDialog"].hide
    end
  end
  
  #LinuxOSの端末上でで使えるpdftotextを使ってPDFファイルからテキストファイルを生成する。
  def pdf2txt(fname)
    result = `pdftotext #{fname}`
    @glade["FileChooserDialog"].hide
    dir, name = File::split(fname)
    return "#{dir}/#{File::basename(fname,".*")}.txt"
  end

  #ファイル選択ダイアログでキャンセルを押した際に呼び出されるシグナル。
  def on_cancelB_clicked(widget)
    @glade["FileChooserDialog"].hide
  end

  #左クリックが話されたとき呼び出されるシグナル。
  #ドラッグで選択した文字列の訳語をテキストビューワーに表示する。
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

  #メニューバーの[ヘルプ]->[情報]で呼び出されるシグナル。
  def on_about_activate(widget)
    @glade["aboutdialog"].show_all
  end
end

#メイン。Tpdfクラスを生成。
if __FILE__ == $0
  # Set values as your own application. 
  PROG_PATH = "transpdf.glade"
  PROG_NAME = "YOUR_APPLICATION_NAME"
  Tpdf.new(PROG_PATH, nil, PROG_NAME)
  Gtk.main
end
