;;; ukrainian.el --- display, translate and edit buffers containing
;; ukrainian characters in various encodings. Supports different fonts
;; (or transliterations), buffer encodings, keyboard layouts and
;; insertion modes. 

;; REQUIRES GNU Emacs version 19

;; Copyright (C) 1994 Valery Alexeev <ava@math.jhu.edu>
;; Copyright (C) 1995 Oleh Baran <oleh@physics.mcgill.ca>
;; Copyright (C) 1996 Stephen Bobick <bobick@darwin.com>
;; Copyright (C) 1999 Dmytro Kovalev <kov@tokyo.email.ne.jp>

;; Added support for XEmacs: Dmytro Kovalev <kov@tokyo.email.ne.jp>
;;    28 Apr 1999
;;
;; Author: Valery Alexeev <ava@math.jhu.edu>
;;   Comments, suggestions and bug reports welcome.
;; Created: 14 Jan 1994
;; Modified for ukrainian language by: Oleh Baran, September 1995
;; Version: 1.3
;; Last modified: Tue Jan  9 21:04:40 EST 1996
;; Status: beware of the bugs!
;; Keywords: foreign, ukrainian
;; Recent changes in code:
;;    1) 7koi is fixed in a way that "&" coresponds to "i" ,
;; "'" coresponds to "ye", etc...
;; Changes done for version 1.2 
;;    1) "8koi" encoding modified. Now it's close to one of 
;; ukrainian standard encodings called koi-8-u, (author Ihor
;; Sviridov). This encoding is currently mostly used on net.
;; (The one used by Mykola Sereda)
;;    2) new ukrainian encoding "UKOI" is now suggested. The basic idea
;; of this encoding is that the codes of specific urkainian characters
;; "i" "yi" "ye" etc. are replaced by the codes of respective latin
;; characters.  While used as an ukrainian font "ukoi" should be
;; convenient for UNIX user to read and type text in true ukrainian
;; KOI-8 encoding.
;;    3) Default settings of parameters are now changed to accord 
;; UNIX users who don't have ukrainian specific fonts on the system
;; and would be able now to read/write ukrainian text more easily
;; using "ukoi" as a font.
;;    4) ukrainian-encoding-broken-8koi-decoding-rule now can translate
;; respective codes "=A6" and "=A4" of ukrainian characters "i" and 
;; "ye". Similarly encoding-libcon-decoding-rule is modified.
;;    5) "dkoi" encoding disabled as one practically never used.

;; For COPYING CONDITIONS use GNU GENERAL PUBLIC LICENSE including the
;; NO WARRANTY FOR ANYTHING WHATSOEVER clause.

;;; Commentary:
;;
;; With this program, you will be able to:
;;   1) Display buffers containing ukrainian characters in arbitrary
;; encodings without changing the buffers' contents if you have at least
;; one ukrainian font installed on your system.
;;   2) Same as above if you do not have any ukrainian fonts at all, using
;; your favourite transliteration scheme.
;;   3) Translate whole buffers or regions of text from one ukrainian
;; standard to another, including arbitrary transliterations.
;;   4) Consequently, print files with ukrainian characters if you have at
;; least one printable ukrainian font.
;;   5) Type ukrainian characters in arbitrary encodings and using
;; arbitrary keyboard layouts. 
;;
;; The basic concept of this program is an encoding which is simply a
;; string of 66 characters or a list of 66 strings, for all the
;; letters of Ukrainian alphabet, 33 letters in lower case first, then
;; 33 letters in upper case. There are also extra bits of information
;; for encodings that mess up the usual ASCII characters, such as
;; "jcuken" for example. You can easily add as many new encodings as
;; you like, see "Customisization" below to find out how to do this.  
;; 
;;; The predefined encodings are:
;; 
;; 8koi     KOI-8 RFC 1489 = old KOI-8 GOST 19768-74 with SMALL IO and
;;            CAPITAL IO added, used in relcom.* newsgroups and much of e-mail
;; 7koi     KOI-7
;; alt      Alternativnyj Variant = MS DOS code page CP 866
;; gostcii  ISO 8859-5
;; osn      Osnovnoj Variant (the only difference in the cyrillic
;;            range between this standard and GOSTCII is CAPITAL IO)
;; cp1251   MS Windows code page CP 1251
;; mac      Macintosh standard
;; ukoi     UKOI-8, codes of specific ukrainian charcters replaced
;;          by codes of respective latin characters
;; cp500    code page CECP 500, obscure
;; ebcdic   EBCDIC GOST 19768-74, obscure
;; ascii    american keyboard, phonetic transliteration,
;;            probably, the most natural keyboard layout
;; jcuken   russian/ukrainian typewriter keyboard layout, used in some TrueType
;;            fonts for MS Windows 
;; libcon   Library of Congress transliteration standard
;; naive    the most common transliteration
;; tex      AMSTeX & LaTeX transliteration
;; broken-8koi  this is what some mailers/gateways do to your email
;;              to/from Ukraine
;; ascii2   one more transliteration, without SMALL IO, CAPITAL IO and
;;            CAPITAL HARD SIGN
;;            
;; Information about various standards was taken in part from files in 
;; the directory 
;;   /anonymous@nic.funet.fi:/pub/culture/russian/comp/characters,
;; in particular from 
;; cyrillic.encoding.faq by Andras Kornai <andras@calera.com>,  
;; lettermappings.gz by Dmitri Vulis <dlv@sunyvms1.bitnet> and RFC 1489. 
;; and also gopher://infomeister.osc.edu:74/00/ukrainian/lang/translit.asc
;; 
;; If you know of more standards, please contribute. 

;;; Installation:
;; Put the following in your .emacs, modified according to your
;; preferences. Below the default values are shown that will be
;; assigned automatically if you fail to set them yourself. 
;;   
;;       ;; Not nesessary unless you set different values.
;;       (setq ukrainian-font-name "ukoi")
;;       (setq ukrainian-buffer-name "8koi")
;;       (setq ukrainian-keyboard-name "ascii")
;;       (setq ukrainian-mode-name "8koi")
;;      
;;       ;; This is important. Make sure the program is on your
;;       ;; load-path (check it with C-h v load-path).     
;;       (require 'ukrainian)   
;;
;; If you want to envoke the ukrainian display automatically, add
;;       (ukrainian-display) 
;;    
;; Finally, don't forget to M-x byte-compile-file ukrainian.el. 

;;; Usage:

;;; Display:    
;; The function 
;;
;;       M-x ukrainian-display 
;;       
;; sets the standard display table so that you can see ukrainian
;; characters encoded according to various standards. The actual file
;; or a buffer won't change, only the way of presenting it. The
;; function needs two parameters: the buffer type and the font. For
;; the buffer type you will be prompted. The font is the font already
;; installed on your system or a transliteration which for the
;; purposes of this program is also considered to be a font. You are
;; not likely to change it often, so the function uses a value already
;; set in your .emacs or the default one. Interactively, you can change
;; this value with M-x ukrainian-set-font. With a positive numerical
;; argument, for example   
;;       
;;       ESC 1 M-x ukrainian-display      
;;    
;; only the display table of the current buffer will be set, and this
;; won't affect other buffers. This way, you can display 
;; many buffers at once, each in its own encoding and even using
;; it's own font (or a transliteration). With a nonpositive argument,
;; for example 
;;     
;;       ESC - 1 M-x ukrainian-display
;;    
;; it acts much as the function without any argument but resets the
;; current buffer's display table so it adheres the default display again. 
;;    
;; The function also has its counterpart,
;;    
;;       M-x ukrainian-undisplay
;;
;; which restores the standard display table to its original state,
;; that is displaying characters higher than 127 in the octal notation.
;; Similarly, given a positive argument it will affect only the local
;; display and with a nonpositive argument it will in addition make
;; the local table obey the default. 

;;; Translation.
;;
;;       M-x ukrainian-translate-region and
;;       M-x ukrainian-translate-buffer
;;
;; will prompt you for the buffer encoding and the new encoding. It
;; translates even from a non 1-to-1 encoding such as the "libcon" or
;; the "naive" encodings and does a better job at it than you'd
;; expect. Translation from "tex" is not currently implemented. It
;; doesn't seem to be very useful and I felt that writing a decoding
;; rule for "tex" would be a tedious and a fruitless job. But if you
;; need it let me know. The completion is enabled so when prompted you
;; can hit TAB to see all available standards. 
;; The translation between the "string" type encodings (see below) is
;; the fastest, translation from a "string" type to a "list" type is
;; considerably slower and the translation from the "list" type 
;; sometimes gets really slow depending on the size of a region/buffer.

;;; Editing.
;;  
;;       M-x ukrainian-insert-mode
;;
;; toggles a minor mode. When in this mode, typing `a' will actually
;; produce a character corresponding to `a' in the encoding chosen,
;; for example, `\301' in KOI-8. The encoding is set in your .emacs.
;; Interactively, you can choose the encoding by invoking this
;; function with a positive argument. The negative argument will
;; always turn the mode off. A "minor" means that all bindings not
;; directly affected by this mode such as all C-... and M-...
;; keystrokes of the major mode remain in effect, as well as the
;; syntax tables and everything else. So you can use this minor mode
;; while in the Mail mode, for example.

;;; Changing the parameters.
;;
;; As has been already explained, you will be prompted for the
;; parameters that you are most likely to change often. At any rate,
;; there are four dedicated functions for changing them
;;
;;       M-x ukrainian-set-font
;;       M-x ukrainian-set-buffer
;;       M-x ukrainian-set-keyboard
;;       M-x ukrainian-set-mode

;;; Customization:
;;
;; All customization should go **before** the line (require 'ukrainian)
;; to take effect. You can customize this program in several ways.
;;   1) Currently all the predefined standards can be used for
;; translation but not all of them can be set as font, buffer,
;; keyboard or insertion mode names. You can change this by setting 
;; the variables 
;;
;;       ukrainian-font-additional-list  
;;       ukrainian-buffer-additional-list 
;;       ukrainian-keyboard-additional-list 
;;       ukrainian-mode-additional-list
;;
;; For example,
;;
;;       (setq ukrainian-font-additional-list 
;;         '("dkoi" "cp500"))
;;
;;   2) You can add more encodings. First, you have to define an
;; encoding ukrainian-encoding-whatever and it should be a string of
;; 66 characters (for 33 ukrainian letters in the lower case, then 33
;; letters in the upper case), or a list of 66 strings. You should
;; take a look at the definitions of various encodings in this file.
;; Then, if your encoding is non-standard even in the ASCII range,
;; you should also define ukrainian-encoding-whatever-filter-from and
;; ukrainian-encoding-whatever-filter-to, each of them being a list of 2
;; strings defining the translation rules, compare "jcuken". If your
;; encoding is of the "list" type and you are planning to translate
;; from it then you also need ukrainian-encoding-whatever-decoding-rule.  
;; The latter is a tree-like data structure much as a keymap which
;; contains characters or strings of characters that have to be
;; inserted when a partial completion was succesful.  
;; Positive number at the end or in the middle of a
;; branch means "insert the i-th letter of the Ukrainian alphabet",
;; 0<i<66+1. A negative number i means "insert a character -i" and i=0
;; means "do not insert anything". This flexibility allows programming
;; many different situations easily, for example the case of "e" at
;; the beginning of the word in the "libcon" transliteration. Check
;; out ukrainian-encoding-libcon-decoding-rule for more details.
;;
;; Then you need to define ukrainian-encoding-additional-alist which has
;; the following format
;;
;;  (setq ukrainian-encoding-additional-alist '(
;;     (PROMPT ENCODING MDLNENAME DECODING-RULE FILTER-FROM FILTER-TO)
;;     (same for the second additional encoding etc.)
;;  ))
;;
;; Here PROMPT is a string easy to type, for example "wtvr", ENCODING
;; is the name of the variable defining the encoding, in our case 
;; ukrainian-encoding-whatever, MDLNENAME is a string for the modeline, i.e.
;; "WHATEVER", DECODING-RULE is ukrainian-encoding-whatever-decoding-rule 
;; or nil, and FILTERS are ukrainian-encoding-whatever-filter-to (resp.
;; from) or nil.
;;
;;; Restrictions:
;; 1) ukrainian-buffer-additional-list and ukrainian-keyboard-additional-list
;; should contain only names of encodings of the "string" type.
;; 2) encodings that are nonstandard even in the ASCII range should
;; have the "string" type. 

;;; Other foreign languages.
;;
;; I thought about writing a generic package so that fitting it for a
;; particular language would be simply a matter of plugging in the
;; right data. In the end, however, I decided against this in favor of
;; a more straightforward approach.
;; To make an <insert the language>.el simply copy this file, 
;; M-x query-replace ukrainian RET <insert the language> RET,
;; change the language-specific encodings and default-alists and adjust
;; headers and documentation accordingly. For most letter-based
;; languages that should be all.  

;; This code is available from:
;; ftp ftp.cam.org
;; login anonymous
;; cd /users/ukugmtl/software/unix

;; LCD Archive Entry:
;; russian.el|Valery Alexeev|ava@math.jhu.edu|
;; Display, translate and edit buffers containing russian characters.|
;; 14-Jan-1994|1.0|~/packages/russian.el.Z|

;;; Code:

;;;; Basic definitions and preliminary functions

;; User configurable variables 
;; (configure them in your .emacs, not here). 
(defvar ukrainian-font-name "ukoi")
(defvar ukrainian-buffer-name "8koi")
(defvar ukrainian-keyboard-name "jcuken")
(defvar ukrainian-mode-name "8koi")

(defvar ukrainian-encoding-additional-alist nil)
;; (defvar ukrainian-font-additional-list nil) 
(setq ukrainian-font-additional-list 
  '("ukoi"))
;; (defvar ukrainian-font-additional-list t) 
(defvar ukrainian-buffer-additional-list nil)
(defvar ukrainian-keyboard-additional-list nil) 
(defvar ukrainian-mode-additional-list nil)
;; User configurable variables end here.

;;;; Defaults.
(defconst ukrainian-encoding-default-alist
  '(("ascii" ukrainian-encoding-ascii "ASCII")
     ("7koi" ukrainian-encoding-7koi "KOI-7")
     ("alt"  ukrainian-encoding-alt "ALT")
     ("8koi"  ukrainian-encoding-8koi "KOI-8")
     ("mac" ukrainian-encoding-mac "MAC")
     ("cp1251" ukrainian-encoding-cp1251 "CP1251")
     ("osn" ukrainian-encoding-osn "OSN")
     ("gostcii" ukrainian-encoding-gostcii "GOSTCII")
     ("naive" ukrainian-encoding-naive "NAIVE" 
      ukrainian-encoding-naive-decoding-rule)
     ("libcon" ukrainian-encoding-libcon "LibCon"
      ukrainian-encoding-libcon-decoding-rule)
     ("broken-8koi" ukrainian-encoding-broken-8koi "BrknKOI-8" 
      ukrainian-encoding-broken-8koi-decoding-rule)
     ("tex" ukrainian-encoding-tex "CyrTeX")
     ("jcuken" ukrainian-encoding-jcuken "JCUKEN" nil
      ukrainian-encoding-jcuken-filter-from ukrainian-encoding-jcuken-filter-to)
     ("cp500" ukrainian-encoding-cp500 "CP500")
     ("ebcdic" ukrainian-encoding-ebcdic "EBCDIC")
     ("ukoi" ukrainian-encoding-ukoi "UKOI")
     ("ascii2" ukrainian-encoding-ascii2 "ASCII-2")))
(defconst ukrainian-font-default-list 
  '("ascii" "7koi" "alt" "8koi" "mac" "cp1251" "osn" 
    "gostcii" "naive" "libcon" "jcuken")) 
(defconst ukrainian-buffer-default-list 
  '("ascii" "7koi" "alt" "8koi" "mac" "cp1251" "osn" 
    "gostcii" "jcuken" "cp500" "ebcdic" "ukoi")) 
(defconst ukrainian-keyboard-default-list
  '("ascii" "jcuken")) 
(defconst ukrainian-mode-default-list 
  '("7koi" "alt" "8koi" "mac" "cp1251" "osn" "gostcii" 
    "naive" "libcon" "broken-8koi" "tex" "jcuken"))

(defconst ukrainian-safe-encoding-name "8koi"
"This should be an encoding of the \"string\" type and coincide with
ASCII for characters below 127.") 


;;;; Setting the variables.
(defvar ukrainian-font nil)
(defvar ukrainian-buffer nil)
(defvar ukrainian-keyboard nil)
(defvar ukrainian-mode nil)

(defvar ukrainian-encoding-alist 
  (append ukrainian-encoding-default-alist ukrainian-encoding-additional-alist))
(defvar ukrainian-font-list 
  (append ukrainian-font-default-list ukrainian-font-additional-list)) 
(defvar ukrainian-buffer-list 
  (append ukrainian-buffer-default-list ukrainian-buffer-additional-list))
(defvar ukrainian-keyboard-list 
  (append ukrainian-keyboard-default-list ukrainian-keyboard-additional-list)) 
(defvar ukrainian-mode-list 
  (append ukrainian-mode-default-list ukrainian-mode-additional-list)) 

(defvar ukrainian-font-alist nil)
(defvar ukrainian-buffer-alist nil)
(defvar ukrainian-keyboard-alist nil)
(defvar ukrainian-mode-alist nil)

(let ((i 0)
      (max (length ukrainian-font-list)))
  (while (< i max)
    (setq ukrainian-font-alist
	  (cons (list (nth i ukrainian-font-list)) ukrainian-font-alist))
    (setq i (+ 1 i))))
(let ((i 0)
      (max (length ukrainian-buffer-list)))
  (while (< i max)
    (setq ukrainian-buffer-alist
	  (cons (list (nth i ukrainian-buffer-list)) ukrainian-buffer-alist)) 
    (setq i (+ 1 i))))
(let ((i 0)
      (max (length ukrainian-keyboard-list)))
  (while (< i max)
    (setq ukrainian-keyboard-alist
	  (cons (list (nth i ukrainian-keyboard-list)) ukrainian-keyboard-alist)) 
    (setq i (+ 1 i))))
(let ((i 0)
      (max (length ukrainian-mode-list)))
  (while (< i max)
    (setq ukrainian-mode-alist
	  (cons (list (nth i ukrainian-mode-list)) ukrainian-mode-alist)) 
    (setq i (+ 1 i))))
  



;;;; Definitions for encodings.
(defconst ukrainian-encoding-ascii
  (concat
   "abwg\\de^vzyi#jklmnoprstufhc=[]`qx"
   "ABWG|DE&VZYI$JKLMNOPRSTUFHC+{}~QX"
   "\'!\"?;:,.*()_\000\000-\000"))

(defconst ukrainian-encoding-7koi
  (concat
   "ABWG1DE$VZI&'JKLMNOPRSTUFHC^[]@QX"
   "abwg2de4vzi67jklmnoprstufhc~{}`qx"
   "\'!\"?;:,.*()_+`-="))

(defconst ukrainian-encoding-alt
  (concat
   "\240\241\242\243\363\244\245\365\246"
   "\247\250\367\371\251\252\253\254"
   "\255\256\257\340\341\342\343\344"
   "\345\346\347\350\351\356\357\354"
   "\200\201\202\203\362\204\205\364\206"
   "\207\210\366\370\211\212\213\214"
   "\215\216\217\220\221\222\223\224"
   "\225\226\227\230\231\236\237\234"
   "\'!\"?;:,.*()_+`-="))

(defconst ukrainian-encoding-8koi
  (concat
   "\301\302\327\307\255\304\305\244\326"
   "\332\311\246\247\312\313\314\315"
   "\316\317\320\322\323\324\325\306"
   "\310\303\336\333\335\300\321\330"
   "\341\342\367\347\275\344\345\264\366"
   "\372\351\266\267\352\353\354\355"
   "\356\357\360\362\363\364\365\346"
   "\350\343\376\373\375\340\361\370"
   "\'!\"?;:,.*()_+`-="))

(defconst ukrainian-encoding-gostcii 
  (concat
   "\320\321\322\323\324\325\361\326\327"
   "\330\331\332\333\334\335\336\337"
   "\340\341\342\343\344\345\346\347"
   "\350\351\352\353\354\355\356\357"
   "\260\261\262\263\264\265\241\266\267"
   "\270\271\272\273\274\275\276\277"
   "\300\301\302\303\304\305\306\307"
   "\310\311\312\313\314\315\316\317"
   "\'!\"?;:,.*()_+`-="))

(defconst ukrainian-encoding-osn 
  (concat
   "\320\321\322\323\324\325\361\326\327"
   "\330\331\332\333\334\335\336\337"
   "\340\341\342\343\344\345\346\347"
   "\350\351\352\353\354\355\356\357"
   "\260\261\262\263\264\265\360\266\267"
   "\270\271\272\273\274\275\276\277"
   "\300\301\302\303\304\305\306\307"
   "\310\311\312\313\314\315\316\317"
   "\'!\"?;:,.*()_+`-="))

(defconst ukrainian-encoding-cp1251
  (concat
   "\340\341\342\343\264\344\345\272\346"
   "\347\350\263\277\351\352\353\354"
   "\355\356\357\360\361\362\363\364"
   "\365\366\367\370\371\376\377\374"
   "\300\301\302\303\245\304\305\252\306"
   "\307\310\262\257\311\312\313\314"
   "\315\316\317\320\321\322\323\324"
   "\325\326\327\330\331\336\337\334"
   "\'!\"?;:,.*()_+`-="))

(defconst ukrainian-encoding-mac
  (concat
   "\340\341\342\343\266\344\345\271\346"
   "\347\350\264\273\351\352\353\354"
   "\355\356\357\360\361\362\363\364"
   "\365\366\367\370\371\376\337\374"
   "\200\201\202\203\242\204\205\270\206"
   "\207\210\247\272\211\212\213\214"
   "\215\216\217\220\221\222\223\224"
   "\225\226\227\230\231\236\237\234"
   "\'!\"?;:,.*()_+`-="))

(defconst ukrainian-encoding-cp500
  (concat 
   "\254\151\355\356\353\357\111\354\277"
   "\200\375\376\373\374\255\256\131"
   "\104\105\102\106\103\107\234\110"
   "\124\121\122\123\130\125\126\127"
   "\220\217\352\372\276\240\252\266\263"
   "\235\332\233\213\267\270\271\253"
   "\144\145\142\146\143\147\236\150"
   "\164\161\162\163\170\165\166\167"
   "\'!\"?;:,.*()_+`-="))

(defconst ukrainian-encoding-ukoi
  (concat
   "\301\302\327\307\304\305\145\326\332"
   "\311\312\313\314\315\316\317\320"
   "\322\323\324\325\306\310\303\336"
   "\333\335\151\151\330\331\300\321"
   "\341\342\367\347\344\345\105\366\372"
   "\351\352\353\354\355\356\357\360"
   "\362\363\364\365\346\350\343\376"
   "\373\375\111\111\370\371\340\361"
   "\'!\"?;:,.*()_+`-="))

(defconst ukrainian-encoding-ebcdic
  (concat
   "\237\240\252\253\254\255\335\256\257"
   "\260\261\262\263\264\265\266\267"
   "\270\271\272\273\274\275\276\277"
   "\312\313\314\315\316\317\332\333"
   "\130\131\142\143\144\145\102\146\147"
   "\150\151\160\161\162\163\164\165"
   "\166\167\170\200\212\213\214\215"
   "\216\217\220\232\233\234\235\236"
   "\'!\"?;:,.*()_+`-="))

(defconst ukrainian-encoding-jcuken
  (concat 
   "f,du]lt';psb\\qrkvyjghcnea[wxio.zm"
   "F<DU}LT\":PSB|QRKVYJGHCNEA{WXIO>ZM"
   "~!@#$%^&*()_+`-="))

(defconst ukrainian-encoding-naive
  '("a"  "b"  "v"  "h"  "g"    "d"  "e"  "ye" "zh"
    "z"  "y"  "i"  "yi" "j"    "k"  "l"  "m"  
    "n"  "o"  "p"  "r"  "s"    "t"  "u"  "f" 
    "kh" "c"  "ch" "sh" "shch" "yu" "ya" "'"
    "A"  "B"  "V"  "H"  "G"    "D"  "E"  "Ye" "Zh" 
    "Z"  "Y"  "I"  "Yi" "J"    "K"  "L"  "M" 
    "N"  "O"  "P"  "R"  "S"    "T"  "U"  "F" 
    "Kh" "C"  "Ch" "Sh" "Shch" "Yu" "Ya" "'"
    "'"  "!"  "\"" "?"    ";"  ":"  ","  "."
    "*"  "("  ")"  "_"    "+"  "`"  "-"  "="))

(defconst ukrainian-encoding-libcon
  '("a" "b" "v" "h" "d" "e" "ye" "zh" "z"
    "y" "j" "k" "l" "m" "n" "o" "p"
    "r" "s" "t" "u" "f" "kh" "ts" "ch"
    "sh" "shch" "yi" "i" "'" "\"" "yu" "ya"
    "A" "B" "V" "H" "D" "E" "YE" "ZH" "Z"
    "Y" "J" "K" "L" "M" "N" "O" "P"
    "R" "S" "T" "U" "F" "KH" "TS" "CH"
    "SH" "SHCH" "YI" "I" "'" "\"" "YU" "YA"
    "'"  "!"  "\"" "?"    ";"  ":"  ","  "."
    "*"  "("  ")"  "_"    "+"  "`"  "-"  "="))

(defconst ukrainian-encoding-broken-8koi
  '("=C1" "=C2" "=D7" "=C7" "=B1" "=C4" "=C5" "=A4" "=D6"
    "=DA" "=C9" "=A6" "=A7" "=CA" "=CB" "=CC" "=CD"
    "=CE" "=CF" "=D0" "=D2" "=D3" "=D4" "=D5" "=C6"
    "=C8" "=C3" "=DE" "=DB" "=DD" "=C0" "=D1" "=D8"
    "=E1" "=E2" "=F7" "=E7" "=B2" "=E4" "=E5" "=B4" "=F6"
    "=FA" "=E9" "=B6" "=B7" "=EA" "=EB" "=EC" "=ED"
    "=EE" "=EF" "=F0" "=F2" "=F3" "=F4" "=F5" "=E6"
    "=E8" "=E3" "=FE" "=FB" "=FD" "=E0" "=F1" "=F8"
    "'"   "!"   "\""  "?"   ";"   ":"   ","   "."
    "*"   "("   ")"   "_"   "+"   "`"   "-"   "="))

(defconst ukrainian-encoding-broken-8koi-decoding-rule
  '(nil
    (?\= (nil
	  (?0 (nil
	       (?9 . -9)))
	  (?2 (nil
	       (?0 . -32)))
	  (?\n . 0)
	  (?A (nil
	       (?6 . 29)
	       (?4 . 7)
	       (?3 . 7)))
	  (?B (nil
	       (?3 . 40)))
	  (?C (nil
	       (?0 . 32)
	       (?1 . 1)
	       (?2 . 2)
	       (?3 . 24)
	       (?4 . 5)
	       (?5 . 6)
	       (?6 . 22)
	       (?7 . 4)
	       (?8 . 23)
	       (?9 . 10)
	       (?A . 11)
	       (?B . 12)
	       (?C . 13)
	       (?D . 14)
	       (?E . 15)
	       (?F . 16)))
	  (?D (nil
	       (?0 . 17)
	       (?1 . 33)
	       (?2 . 18)
	       (?3 . 19)
	       (?4 . 20)
	       (?5 . 21)
	       (?6 . 8)
	       (?7 . 3)
	       (?8 . 30)
	       (?9 . 29)
	       (?A . 9)
	       (?B . 26)
	       (?C . 31)
	       (?D . 27)
	       (?E . 25)
	       (?F . 28)))
	  (?E (nil
	       (?0 . 65)
	       (?1 . 34)
	       (?2 . 35)
	       (?3 . 57)
	       (?4 . 38)
	       (?5 . 39)
	       (?6 . 55)
	       (?7 . 37)
	       (?8 . 56)
	       (?9 . 43)
	       (?A . 44)
	       (?B . 45)
	       (?C . 46)
	       (?D . 47)
	       (?E . 48)
	       (?F . 49)))
	  (?F (nil
	       (?0 . 50)
	       (?1 . 66)
	       (?2 . 51)
	       (?3 . 52)
	       (?4 . 53)
	       (?5 . 54)
	       (?6 . 41)
	       (?7 . 36)
	       (?8 . 63)
	       (?9 . 62)
	       (?A . 42)
	       (?B . 59)
	       (?C . 64)
	       (?D . 60)
	       (?E . 58)
	       (?F . 61)))))))

(defconst ukrainian-encoding-libcon-decoding-rule
  '(nil
    (?a . 1)
    (?b . 2)
    (?c (24
	 (?h . 25)))
    (?d . 5)
    (?e (6
	 (?f (nil
	      (?f . [31 22 22])))
	 (?l (nil
	      (?e (nil
		   (?k (nil
			(?t (nil
			     (?r . [31 13 6 12 20 18])))))))))))
    (?f . 22)
    (?g . 4)
    (?h . 4)
;;    (?h . 23)
    (?i . 29)
;;    (?i . 10)
    (?j (11
	 (?a . 33)
	 (?o . 7)
	 (?u . 32)))
    (?k (12
	 (?h . 23)))
    (?l . 13)
    (?m . 14)
    (?n . 15)
    (?o . 16)
    (?p (17
	 (?o ([17 16]
	      (?e ([17 16 6]
		   (?t . [17 16 31 20])))
	      (?r (nil
		   (?t (nil
			(?s (nil
			     (?m . [17 16 18 20 19 14])))))))))))
    (?r (18
	 (?t (nil
	      (?s (nil
		   (?i (nil
			(?g . [18 20 19 10 4])))))))))
    (?s (19
	 (?o (nil
	      (?v (nil
		   (?e (nil
			(?t (nil
			     (?s (nil
				  (?k . [19 16 3 6 20 19 12])))))))))))
	 (?c (nil
	      (?h (27
		   (?e ([27 6]
			(?z . [19 25 6 9])))
		   (?i (nil
			(?t (nil
			     (?a . [19 25 10 20 1])))))
		   (?a (nil
			(?s (nil
			     (?t . [19 25 1 19 20])))))))))
	 (?h (26
	      (?c (nil
		   (?h . 27)))))))
    (?t (20
	 (?s (24
	      (?c (nil
		   (?h . [20 27])))
	      (?j (nil
		   (?a . [20 19 33])))
	      (?t . [20 19 20])
	      (?y (nil
		   (?a . [20 19 33])))))))
    (?u . 21)
    (?v . 3)
    (?w . 3)
    (?x . 23)
    (?y (10
;;    (?y (29
	 (?a . 33)
	 (?e . 7)
	 (?i . 28)
	 (?o . 7)
	 (?u . 32)))
    (?z (9
	 (?h . 8)))
    (?A . 34)
    (?B (35
	 (?' . [35 63])))
    (?C (57
	 (?H . 58)
	 (?h . 58)))
    (?D (38
	 (?' . [38 63])))
    (?E (39
	 (?V ([39 36]
	      (?M . [64 36 47])))))
    (?F (55
	 (?' . [55 63])))
    (?G (37
	 (?' . [37 63])))
    (?H (56
	 (?' . [56 63])))
    (?I . 43)
    (?J (44
	 (?A . 66)
	 (?a . 66)
	 (?O . 40)
	 (?o . 40)
	 (?U . 65)
	 (?u . 65)))
    (?K (45
	 (?' . [45 63])
	 (?H . 56)
	 (?h . 56)))
    (?L (46
	 (?' . [46 63])))
    (?M (47
	 (?' . [47 63])))
    (?N (48
	 (?' . [48 63])))
    (?O . 49)
    (?P (50
	 (?' . [50 63])
	 (?O (nil
	      (?R (nil
		   (?T (nil
			(?S (nil
			     (?M . [50 49 51 53 52 47])))))))))))
    (?R (51
	 (?' . [51 63])
	 (?T (nil
	      (?S (nil
		   (?I (nil
			(?G . [51 53 52 43 37])))))))))
    (?S (52
	 (?' . [52 63])
	 (?o (nil
	      (?v (nil
		   (?e (nil
			(?t (nil
			     (?s (nil
				 (?k . [52 16 3 6 20 19 12])))))))))))
	 (?C (nil
	      (?H (60
		   (?I (nil
			(?T (nil
			     (?A . [52 58 43 53 34])))))
		   (?A (nil
			(?S (nil
			     (?T . [52 58 34 52 53])))))))))
	 (?H (59
	      (?' . [59 63])
	      (?C (nil
		   (?H . 60)))))
	 (?c (nil
	      (?h (60
		   (?i (nil
			(?t (nil
			     (?a . [52 25 10 20 1])))))
		   (?a (nil
			(?s (nil
			     (?t . [52 25 1 19 20])))))))))
	 (?h (59
	      (?c (nil
		   (?h . 60)))))))
    (?T (53
	 (?' . [53 63])
	 (?s (57
	      (?j (nil
		   (?a . [53 19 33])))
	      (?t . [53 19 20])
	      (?y (nil
		   (?a . [53 19 33])))))
	 (?S (57
	      (?J (nil
		   (?A . [53 52 66])))
	      (?T . [53 52 53])
	      (?Y (nil
		   (?A . [53 52 66])))))))
    (?U . 54)
    (?V (36
	 (?' . [36 63])))
    (?W (36
	 (?' . [36 63])))
    (?X (56
	 (?' . [56 63])))
    (?Y (62
	 (?A . 66)
	 (?O . 40)
	 (?U . 65)
	 (?a . 66)
	 (?o . 40)
	 (?u . 65)))
    (?Z (42
	 (?' . [42 63])
	 (?H (41
	      (?' . [41 63])))
	 (?h . 41)))
    (?\' . 30)
    (?\  (nil
	  (?s (nil
	       (?c (nil
		    (?h ([-32 19 25]
			 (?i (nil
			      (?p . [-32 27 10 17])))))))))
	  (?e (nil
	       (?n . [-32 31 15])
	       (?k . [-32 31 12])
	       (?p . [-32 31 17])
	       (?t . [-32 31 20])))
	  (?E (nil
	       (?k . [-32 64 12])
	       (?p . [-32 64 17])
	       (?K . [-32 64 45])
	       (?P . [-32 64 50])
	       (?t . [-32 64 20])
	       (?T . [-32 64 53])))))
    (?\t (nil  
	  (?s (nil
	       (?c (nil
		    (?h ([-9 19 25]
			 (?i (nil
			      (?p . [-9 27 10 17])))))))))
	  (?e (nil
	       (?k . [-9 31 12])
	       (?p . [-9 31 17])
	       (?t . [-9 31 20])))
	  (?E (nil
	       (?k . [-9 64 12])
	       (?p . [-9 64 17])
	       (?K . [-9 64 45])
	       (?P . [-9 64 50])
	       (?t . [-9 64 20])
	       (?T . [-9 64 53])))))
    (?\n (nil  
	  (?s (nil
	       (?c (nil
		    (?h ([-10 19 25]
			 (?i (nil
			      (?p . [-10 27 10 17])))))))))
	  (?e (nil
	       (?n . [-10 31 15])
	       (?k . [-10 31 12])
	       (?p . [-10 31 17])
	       (?t . [-10 31 20])))
	  (?E (nil
	       (?k . [-10 64 12])
	       (?p . [-10 64 17])
	       (?K . [-10 64 45])
	       (?P . [-10 64 50])
	       (?t . [-10 64 20])
	       (?T . [-10 64 53])))))
    (?\f (nil  
	  (?s (nil
	       (?c (nil
		    (?h ([-12 19 25]
			 (?i (nil
			      (?p . [-12 27 10 17])))))))))
	  (?e (nil
	       (?n . [-12 31 15])
	       (?k . [-12 31 12])
	       (?p . [-12 31 17])
	       (?t . [-12 31 20])))
	  (?E (nil
	       (?k . [-12 64 12])
	       (?p . [-12 64 17])
	       (?K . [-12 64 45])
	       (?P . [-12 64 50])
	       (?t . [-12 64 20])
	       (?T . [-12 64 53])))))
    (?\r (nil  
	  (?s (nil
	       (?c (nil
		    (?h ([-13 19 25]
			 (?i (nil
			      (?p . [-13 27 10 17])))))))))
	  (?e (nil
	       (?n . [-13 31 15])
	       (?k . [-13 31 12])
	       (?p . [-13 31 17])
	       (?t . [-13 31 20])))
	  (?E (nil
	       (?k . [-13 64 12])
	       (?p . [-13 64 17])
	       (?K . [-13 64 45])
	       (?P . [-13 64 50])
	       (?t . [-13 64 20])
	       (?T . [-13 64 53])))))))

(defconst ukrainian-encoding-naive-decoding-rule
  ukrainian-encoding-libcon-decoding-rule)

(defconst ukrainian-encoding-tex
  '("a"   "b"  "v" "g"  "g"       "d"  "e"   "e2" 
    "zh"  "z"  "i" "i1" "\\\"{=}" "e0" "k"   "l" 
    "m"   "n"  "o" "p"  "r"       "s"  "{t}" "u"
    "f"   "kh" "c" "q"  "x"       "w"  "yu"  "ya" "p1"
    "A"   "B"  "V" "G"  "G"       "D"  "E"   "E2"
    "ZH"  "Z"  "I" "I1" "\\\"I"   "I0" "K"   "L"
    "M"   "N"  "O" "P"  "R"       "S"  "{T}" "U"
    "F"   "Kh" "C" "Q"  "X"       "W"  "Yu"  "Ya" "P1"))

(defconst ukrainian-encoding-ascii2
  (concat
   "abwgde\243vzijklmnoprstufhc^[]_ix\\@q"
   "ABWGDE\263VZIJKLMNOPRSTUFHC~{}\377IX|`Q"))


;;;; Additional encodings outside the cyrillic range.
(defconst ukrainian-encoding-jcuken-filter-from
  '("~`!@#$%^&*_-+=" 
    "+=_!/\":<>?-,;."))
(defconst ukrainian-encoding-jcuken-filter-to
  '("~`!@#$%^&*_-+={[}]:;\"'<,>.?/"
    " $@       !_~`(())%+$$^-&=*#"))

;;;; Functions for changing the variables.
(defun ukrainian-set-font ()
  (interactive)
  (let ((font-name
	 (completing-read 
	  (concat "New ukrainian font or a transliteration (default "
		  ukrainian-font-name
		  "): ")
	  ukrainian-font-alist nil t)))
    (if (not (equal font-name ""))
	(setq ukrainian-font-name font-name))))

(defun ukrainian-set-buffer ()
  (interactive)
  (let ((buffer-name
	 (completing-read 
	  (concat "New encoding of a ukrainian buffer (default "
		  ukrainian-buffer-name
		  "): ")
	  ukrainian-buffer-alist nil t)))
    (if (not (equal buffer-name ""))
	(setq ukrainian-buffer-name buffer-name))))

(defun ukrainian-set-keyboard ()
  (interactive)
  (let ((keyboard-name
	 (completing-read 
	  (concat "New ukrainian keyboard (default "
		  ukrainian-keyboard-name
		  "): ")
	  ukrainian-keyboard-alist nil t)))
    (if (not (equal keyboard-name ""))
	(setq ukrainian-keyboard-name keyboard-name))))

(defun ukrainian-set-mode ()
  (interactive)
  (let ((mode-name
	 (completing-read 
	  (concat "New ukrainian insertion mode (default "
		  ukrainian-mode-name
		  "): ")
	  ukrainian-mode-alist nil t)))
    (if (not (equal mode-name ""))
	(setq ukrainian-mode-name mode-name))))


;;;; Working engine.
(defun ukrainian-univ-nth (string-or-list i)
  (if (listp string-or-list)
      (nth i string-or-list)
    (aref string-or-list i)))

(defun ukrainian-univ-vector (char-or-string)
  (if (stringp char-or-string)
      (apply 'vector (append char-or-string nil))
    (vector char-or-string)))

(defun ukrainian-univ-append (char-or-string string-or-list)
  (if (listp string-or-list)
      (append (vector  char-or-string) string-or-list)
    (concat (vector  char-or-string) string-or-list)))

(defvar ukrainian-temporary-table nil)

(defun ukrainian-get-table (numeric display max long-from long-to) 
  (let* ((from (eval (nth 1 long-from)))
	 (to (eval (nth 1 long-to)))
	 (from-filter (eval (nth 4 long-from)))
	 (to-filter (eval (nth 5 long-to)))
	 (from-filter-from (eval (nth 0 from-filter)))
	 (from-filter-to (eval (nth 1 from-filter)))
	 (to-filter-from (eval (nth 0 to-filter)))
	 (to-filter-to (eval (nth 1 to-filter))))
    (if numeric
	(progn
	  (setq ukrainian-temporary-table (make-string max ?a))
	  (let ((i 0))
	    (while (< i max)
	      (aset ukrainian-temporary-table i i)
	      (setq i (+ 1 i)))))
      (setq ukrainian-temporary-table (make-vector max nil)))
    (let ((real-from from)
	  (real-to to))
      (cond
       ((and from-filter-from to-filter-from)
	(let ((i 0) j
	      char1 char2 char3
	      (flag t)
	      (len1 (length from-filter-from))
	      (len2 (length to-filter-from)))
	  (while (< i len1)
	    (progn
	      (setq char1 (aref from-filter-from i))
	      (setq char2 (aref from-filter-to i))
	      (setq j 0)
	      (while (and flag (< j len2))
		(if (equal char2 (aref to-filter-from j))
		    (progn
		      (setq flag nil)
		      (setq real-from (concat (vector char1) real-from))
		      (setq real-to
			    (if numeric
				(concat (vector (aref to-filter-to j)) real-to) 
			      (ukrainian-univ-append 
			       (ukrainian-univ-nth to-filter-to j) 
			       real-to))))
		  (setq j (+ 1 j))))
	      (if flag 
		  (progn
		    (setq real-from (concat (vector char1) real-from))
		    (setq real-to
			  (if numeric
			      (concat (vector char2) real-to)
			    (ukrainian-univ-append
			     char2 real-to))))))
	    (setq i (+ 1 i)))))
       (from-filter-from
	(let ((i 0)
	      (len1 (length from-filter-from)))
	  (while (< i len1)
	    (progn
	      (setq real-from 
		    (concat (vector (aref from-filter-from i)) real-from))
	      (setq real-to
		    (if numeric
			(concat (vector (aref from-filter-to i)) real-to)
		      (ukrainian-univ-append
		       (ukrainian-univ-nth from-filter-to i)
		       real-to)))
	      (setq i (+ 1 i))))))
       (to-filter-to
	(let ((i 0)
	      (len2 (length to-filter-to)))
	  (while (< i len2)
	    (progn
	      (setq real-from 
		    (concat (vector (aref to-filter-from i)) real-from))
	      (setq real-to
		    (if numeric
			(concat (vector (aref to-filter-to i)) real-to)
		      (ukrainian-univ-append
		       (ukrainian-univ-nth to-filter-to i)
		       real-to)))
	      (setq i (+ 1 i))))))
       (t))
      (let ((i 0)
	    (len (length real-from)))
	(while (< i len)
	  (aset ukrainian-temporary-table
		(aref real-from i)
		(if numeric
		    (aref real-to i)
		  (ukrainian-univ-nth real-to i)))
	  (setq i (+ 1 i))))
      (if display
	  (let ((i 0))
	    (while (< i max)
	      (if (aref ukrainian-temporary-table i)
		  (aset ukrainian-temporary-table
			i
			(ukrainian-univ-vector 
			 (aref ukrainian-temporary-table i))))
	      (setq i (+ 1 i))))))))


;;;; Display part.
(defun ukrainian-display (&optional arg)
  (interactive "P")
  (if (interactive-p) (call-interactively 'ukrainian-set-buffer))
  (let* ((buffer-long 
	  (assoc ukrainian-buffer-name ukrainian-encoding-alist))
	 (font-long
	  (assoc ukrainian-font-name ukrainian-encoding-alist)))

    (ukrainian-get-table nil t 261 buffer-long font-long)

    (if arg
	(if (> (prefix-numeric-value arg) 0)
	    (setq buffer-display-table ukrainian-temporary-table)
	  (progn
	    (setq buffer-display-table nil)
	    (setq standard-display-table ukrainian-temporary-table)))
      (setq standard-display-table ukrainian-temporary-table))))

(defun ukrainian-undisplay (&optional arg)
  (interactive "P")
  (if arg 
      (if (> (prefix-numeric-value arg) 0)
	  (setq buffer-display-table (make-vector 261 nil))
	(progn
	  (setq buffer-display-table nil)
	  (setq standard-display-table (make-vector 261 nil))))
    (setq standard-display-table (make-vector 261 nil))))

;;;; Translation.

(defun ukrainian-translate-string-list (start end translate-table)
  (save-excursion
    (narrow-to-region start end)
    (goto-char 1)
    (while (not (eobp))
      (let* ((char (following-char))
	     (char-to (aref translate-table char)))
	(if char-to
	    (progn
	      (delete-char 1)
	      (insert char-to))
	  (forward-char))))
    (widen)))

(defun ukrainian-translate-decoding-rule (start end decoding-rule to)
  (save-excursion
    (let (decoding-list
	  chars-moved
	  char-to 
	  chars-erase 
	  flag-read-more 
	  flag-match 
	  char-read)
      (narrow-to-region start end)
      (goto-char 1)
      (while  (not (eobp))
	(setq decoding-list decoding-rule)
	(setq chars-moved 0)
	(setq char-to nil)
	(setq chars-erase 0)
	(setq flag-read-more t)
	(setq flag-match t)
	(setq char-read nil)
	(catch 'read-more
	  (progn
	    (setq flag-match t)
	    (while (and flag-read-more (not (eobp)))
	      (progn
		(setq flag-match t)
		(setq char-read (following-char))
		(let ((i 1))
		  (progn
		    (while (and flag-match (< i (length decoding-list)))
		      (progn
			(if (eq char-read (car (nth i decoding-list)))
			    (progn
			      (setq flag-match nil)
			      (setq decoding-list (cdr (nth i decoding-list)))
			      (if (atom decoding-list)
				  (progn
				    (setq flag-read-more nil)
				    (setq chars-erase (+ 1 chars-moved))
				    (setq char-to decoding-list)
				    (throw 'read-more t))
				(progn
				  (setq decoding-list (car decoding-list))
				  (if (car decoding-list)
				      (progn
					(setq char-to (car decoding-list))
					(setq chars-erase (+ 1 chars-moved))))))))
			(setq i (+ 1 i)))
		      )
		    (if flag-match (setq flag-read-more nil))
		    (forward-char)
		    (setq chars-moved (+ 1 chars-moved))))))))
	(backward-char chars-moved)
	(delete-char chars-erase)
	(if char-to
	    (if (vectorp char-to)
		(progn
		  (let ((j 0)
			(n (length char-to)))
		    (while (< j n)
		      (let ((char (aref char-to j)))
			(cond
			 ((> char 0)
			  (insert
			   (if (listp to)
			       (nth (- char 1) to)
			     (aref to (- char 1)))))
			 ((< char 0)
			  (insert (- char)))
			 (t)))
		      (setq j (+ 1 j)))))
	      (cond
	       ((> char-to 0)
		(progn
		  (insert
		   (if (listp to)
		       (nth (- char-to 1) to)
		     (aref to (- char-to 1))))))
	       ((< char-to 0)
		(insert (- char-to)))
	       (t)))
	  (or
	   (eobp)
	   (forward-char))))
      (widen))))

    
(defun ukrainian-translate-region 
  (start end &optional non-interactive from-name to-name)
  "non-interactive should be t if used non-interactively, from-name
and to-name are strings."
  (interactive "r")
  (if (null non-interactive)
      (progn
	(setq from-name
	      (completing-read
	       "Translate from the encoding: "
	       ukrainian-encoding-alist nil t))
	(setq to-name
	      (completing-read
	       "Translate to the encoding: "
	       ukrainian-encoding-alist nil t))))
  (let* 
      (translate-table
       (from-long (assoc from-name ukrainian-encoding-alist))
       (to-long (assoc to-name ukrainian-encoding-alist))
       (from (eval (nth 1 from-long)))
       (to (eval (nth 1 to-long))))
    
    (if (listp from)
	(if (nth 4 to-long)
	    (progn
	      (narrow-to-region start end)
	      (ukrainian-translate-region (point-min) (point-max) t 
					from-name ukrainian-safe-encoding-name)
	      (ukrainian-translate-region (point-min) (point-max) t 
					ukrainian-safe-encoding-name to-name)
	      (widen))
	  (let ((decoding-rule (eval (nth 3 from-long))))
	    (ukrainian-translate-decoding-rule start end decoding-rule to)))

      (if (listp to)
	  (progn
	    (ukrainian-get-table nil nil 256 from-long to-long)
	    (ukrainian-translate-string-list start end 
					   ukrainian-temporary-table))
	(progn
	  (ukrainian-get-table t nil 256 from-long to-long) 
	  (translate-region start end ukrainian-temporary-table)))))) 


(defun ukrainian-translate-buffer ()
  (interactive)
  (ukrainian-translate-region (point-min) (point-max) nil))



;;;; Ukrainian insertion modes.

(defvar ukrainian-insertion-mode nil
  "Non-nil if using ukrainian mode as a minor mode of some other mode.")
(make-variable-buffer-local 'ukrainian-insertion-mode)
(put 'ukrainian-insertion-mode 'permanent-local t)

(defvar ukrainian-insertion-mode-string " UKRAINIAN")

(or (assq 'ukrainian-insertion-mode minor-mode-alist)
    (setq minor-mode-alist 
	  (append minor-mode-alist
		  (list '(ukrainian-insertion-mode 
			  ukrainian-insertion-mode-string)))))

(defvar ukrainian-insertion-mode-map nil)

(defvar ukrainian-insertion-mode-table nil)

(defun ukrainian-insertion-mode (&optional arg)
  "Toggle ukrainian minor mode.
With arg, turn ukrainian minor mode on if arg is positive (and prompt
for the encoding), off otherwise."
  (interactive "P")
  (setq ukrainian-insertion-mode-string " UKRAINIAN")
  (setq ukrainian-insertion-mode
	(if (null arg) (not ukrainian-insertion-mode)
	  (> (prefix-numeric-value arg) 0)))
  (if ukrainian-insertion-mode
      (progn
	(if (and
	     arg
	     (> (prefix-numeric-value arg) 0))
	    (call-interactively 'ukrainian-set-mode nil))
	(let ((long-from (assoc ukrainian-keyboard-name ukrainian-encoding-alist))
	      (long-to (assoc ukrainian-mode-name ukrainian-encoding-alist)))
	  (setq ukrainian-insertion-mode-map (make-sparse-keymap))
	  (ukrainian-get-table nil nil 256 long-from long-to)
	  (setq ukrainian-insertion-mode-table ukrainian-temporary-table)
	  (let ((i 0))
	    (while (< i 256)
	      (let ((char (aref ukrainian-insertion-mode-table i)))
		(if char
		    (define-key ukrainian-insertion-mode-map  
		      (char-to-string i) 
		      'ukrainian-perform-insertion)))
	      (setq i (1+ i))))
	  (run-hooks 'ukrainian-insertion-mode-hook)
	  (setq ukrainian-insertion-mode-string 
		(concat " " 
			(nth 2 long-to))))))
  (set-buffer-modified-p (buffer-modified-p))
  (let ((i 0) test)
    (while (< i (length minor-mode-map-alist))
      (setq test (nth i minor-mode-map-alist))
      (if (eq 'ukrainian-insertion-mode (car test))
	  (progn
	    (setq minor-mode-map-alist (delq test minor-mode-map-alist))
	    (setq i (- i 1))))
      (setq i (+ 1 i))))
  (setq minor-mode-map-alist
	(cons (cons 'ukrainian-insertion-mode ukrainian-insertion-mode-map)
	      minor-mode-map-alist)))


(if (string-equal (substring (emacs-version) 0 3) "GNU")
    (defun ukrainian-perform-insertion ()
      (interactive)
      (insert (aref ukrainian-insertion-mode-table last-command-event)))
  ;; for XEmacsen
  (defun ukrainian-perform-insertion ()
    (interactive)
    (insert (aref ukrainian-insertion-mode-table 
		  (event-to-character last-command-event)))))

(provide 'ukrainian)

;;; ukrainian.el ends here

