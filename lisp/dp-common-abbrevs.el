;;;
;;; 'global abbrevs are for automatic expansion, e.g. common,
;;; unambiguous speling erors like: teh thier.
;;; Another possibility are unambiguous abbreviations:
;;; eg -> e.g., and some capitalization fixes: khz -> KHz.
;;; 'global implies `global-abbrev-table' and abbrevs in that table are
;;; auto expanded in buffers that request it.  I currently have too many
;;; things in there that are expanded annoyingly often, so I need to revisit
;;; the table
;;; ASSIGNMENTS.
;;; 'manual abbrevs are expected to be expanded by hand.
;;; @ todo... add mode to "properties" and then add to table for that mode.
;;; Stems of abbrev tables.  If just a symbol then construct a table name of
;;; @ todo... add 'tmp property to indicate table is not to be saved.
;;;  <sym>-abbrev-table
;;; Abbrev entry format:
;;; ABBREV-ENTRY ::= (ABBREVS/EXPANSIONS TABLE-INFO)
;;; ABBREVS/EXPANSIONS ::= (ABBREV-NAMES EXPANSIONS)
;;; ABBREV-NAMES ::= "abbrev-name" | ("abbrev-name0"...)
;;; EXPANSIONS ::= "expansion0"...
;;; TABLE-INFO ::= TABLE-NAME | TABLE-INFO-PLIST
;;; TABLE-NAME ::= 'table-name-sym | "table-name"  ; it's `format'd w/%s
;;; TABLE-INFO-PLIST ::= (PROP/VAL PROP/VAL ...)
;;; PROP/VAL ::= 'table-name TABLE-NAME
;;;
;;; we define abbrevs: {ABBREV-NAMES} X {EXPANSIONS} X {TABLES}
;;; for each name
;;;     for each table
;;;         define abbrev name expansion[-list]
;;;         ;; expansion[-list] is saved as a string `format'd with %S the
;;;         ;; list can be `read' to recreate the list.  The expansion list
;;;         ;; can be iterated over by successive invocations of
;;;         ;; `dp-expand-abbrev'
;;;         [put props on table variable]
;;;
;;; Come on!  There needs to be the need/ability to use eval'able forms
;;; somewhere!
;;; 
;;; !<@todo ??? Modify data structures to allow a way to add suffixes
;;; programmatically. Eg t for a space? 's for pluralization?
;;; !<@todo Automatically generate "logical" case mixtures.

;;; Convenience binding:
;;; C-c C-c (dp-save-and-redefine-abbrevs)
;;; 
(defconst dp-common-abbrevs
  '((("teh" "the" "duh" "D'OH!")
     dp-manual global)
    (("plisttest" "a test of the plist type table.")
     (table-name dp-manual tmp t)
     (table-name dp-plists))
    
    ;; !<@todo XXX Determine final resting place of mode specific abbrevs.
    (("cs" "c_str()")
     (table-name dp-c++-mode))
    (("onlyinCmode" "ayup")
     (table-name dp-c++-mode))
    
    (("nn" "non-nil")
     dp-manual)
    (("wrt" "WRT" "with respect to")
     dp-manual)
    (("dtrt" "DTRT" "do the right thing")
     dp-manual)
    (("st" "such that ")
     dp-manual)
    ((("wether" "wheter")
      "whether")
     dp-manual global)
    (("thru" "through")
     dp-manual global)
    (("thot" "thought")
     dp-manual global)
    (("tho" "though" "although")
     dp-manual global)
    ((("dap" "dp" "DAP" "DP" "davep") "David A. Panariti")
     dp-manual)
    (("stl" "STL")
     dp-manual)
    (("mobo" "motherboard")
     dp-manual)
    (("altho" "although")
     dp-manual global)
    (("kb" "keyboard" "KB")             ; Works for kilobyte and keyboard.
     dp-manual)
    (("eg" "e.g.")
     dp-manual)
    (("qv" "q.v.")
     dp-manual)
    (("ie" "i.e.")
     dp-manual)
    (("nb" "N.B.")
     dp-manual)
    (("plz" "please")
     dp-manual)
    (("sthg" "something")
     dp-manual global)
    ((("iir" "IIR" "Iir")
      "if I recall" "IIR")
     dp-manual)
    ((("appt" "appts")
      "appointments" "appointment")
     dp-manual)
    (("ok" "OK")
     dp-manual global)
    (("wtf" "WTF")
     dp-manual global)
    (("fo" "of")
     dp-manual global)
    ((("decl" "decls")
      "declaration" "declarations")
     dp-manual)
    (("pred" "predicate" "predicates")
     dp-manual)
    (("def" "definition" "define")
     dp-manual)
    (("defs" "definitions" "defines")
     dp-manual)
    (("prob"
      "problem" "problems")
     dp-manual)
    (("probs" "problems")
     dp-manual)
    (("gui" "GUI")
     dp-manual)
    (("bup" "backup" "backups")
     dp-manual)
    (("bups" "backups")
     dp-manual)
    (("khz" "KHz")
     dp-manual global)
    (("mhz" "MHz")
     dp-manual global)
    (("ghz" "GHz")
     dp-manual global)
    (("kbps" "Kbps")
     dp-manual global)
    (("gbps" "Gbps")
     dp-manual global)
    (("ns" "nS")
     dp-manual global)
    (("ms" "mS" global)
     dp-manual)
    (("linux" "Linux" "LINUX" "LiGNUx")
     dp-manual)
    (("thier" "their")
     dp-manual global)
    (("beleive" "believe")
     dp-manual global)
    (("yopp" "YOPP!")
     dp-manual global)
    (("yop" "YOPP!")
     dp-manual)
    ((("repos" "repo") "repository")
     dp-manual)
    (("e2ei" "RSVP-E2E-IGNORE")
     dp-manual)
    ((("LARTC" "lartc") "Linux Advanced Routing & Traffic Control HOWTO")
     dp-manual)
    (("pkt" "packet")
     dp-manual)
    (("lenght" "length")
     dp-manual global)
    ((("recieve" "rx" "RX") "receive")
     dp-manual global)
    (("reciever" "receiver")
     dp-manual global)
    ((("rxer" "rxor" "rxr")
      "receiver")
     dp-manual)
    (("nic" "NIC" "network interface card")
     dp-manual)
    (("tcp/ip" "TCP/IP")
     dp-manual)
    (("udp" "UDP")
     dp-manual)
    (("q" "queue" "enqueue")
     dp-manual)
    ((("enq" "nq") "enqueue")
     dp-manual)
    ((("deq" "dq") "dequeue")
     dp-manual)
    ((("xlation" "xlat")
      "translation" "translate")
     dp-manual)
    ((("xmission" "xmit" "tx")
      "transmission" "transmit")
     dp-manual)
    ((("seq" "seqs")
      "sequences" "sequence")
     dp-manual)
    (("foriegn" "foreign")
     dp-manual global)
    (("yeild" "yield")
     global)
    (("peice" "piece")
     global)
    ((("govt" "gov")
      "government")
     dp-manual)
    (("wadr" "with all due respect")
     dp-manual)
    (("att" "at this time")
     dp-manual)
    (("atow" "at time of writing")
     dp-manual)
    ((("FHR" "fhr") "for historical reasons")
     dp-manual)
    (("provate" "private")
     dp-manual global)
    (("yko" "echo")
     dp-manual global)
    (("strenght" "strength")
     dp-manual global)
    (("WH" "White House")
     dp-manual)
    (("admin" "administration")
     dp-manual)
    (("christian" "xian")
     dp-manual)
    (("xian" "christian")
     dp-manual)
    ((("xemacs" "xem")
      "XEmacs")
     dp-manual)
    (("python" "Python")
     dp-manual)
    (("tcp" "TCP")
     dp-manual)
    (("ip" "IP")
     dp-manual)
    ((("filesystem" "fs" "FS" ) "file system")
     dp-manual)
    (("Filesystem" "File system")
     dp-manual)
    ((("filename" "fname") "file name" "File name")
     dp-manual)
    ((("fd" "fdesc") "file descriptor" "File descriptor")
     dp-manual)
    (("symlink" "symbolic link")
     dp-manual)
    (("Symlink" "Symbolic link")
     dp-manual)
    (("autosave" "auto save")
     dp-manual)
    (("Autosave" "Auto save")
     dp-manual)
    ((("keymap" "key maps")
      "key map" "key maps")
     dp-manual)
    (("beg" "begin")
     dp-manual)
    (("begin" "beg")
     dp-manual)
    (("ws" "white space")
     dp-manual)
    (("whitespace" "white space")
     dp-manual)
    (("qs" "questions")
     dp-manual)
    (("var" "variable")
     dp-manual)
    (("vars" "variables")
     dp-manual)
    (("env" "environment")
     dp-manual)
    ((("envv" "envvar" "evar" "envar" "ev")
      "environment variable" "environment variables")
     dp-manual)
    (("info" "information")
     dp-manual)
    (("init" "initial")
     dp-manual)
    (("exe" "executable")
     dp-manual)
    ((("bin" "bina")
      "binary")
     dp-manual)
    (("ISTR" "I seem to recall")
     dp-manual)
    (("ding" "ba DooM!")                ; WTF?
     dp-manual)
    ((("STFU" "stfu")
      "please be quiet" "hush" "hushup" "shhhh")
     dp-manual)
    (("goto" "go to")
     dp-manual)
    (("ww" "wall wart")
     dp-manual)
    (("flsit" "flist")                  ; Historical
     dp-manual)
    (("dpdx" "DP_DASH_X=t")
     dp-manual)
    (("dev" "development" "develop" "device")
     dp-manual)
    (("devs" "developers" "devices")
     dp-manual)
    (("devel" "development" "develop")
     dp-manual)
    (("memf" "member function" "member field")
     dp-manual)
    (("mfunc" "member function" "member field")
     dp-manual)
    ((("dir" "dirs")
      "directory" "directories")
     dp-manual)
    ((("subdir" "subdirs")
      "subdirectory" "subdirectories"
      "sub-directory" "sub-directories")
     dp-manual)
    ((("paren" "parens")
      "parenthesis" "parentheses" "parenthesize")
     dp-manual)
    (("orig" "original")
     dp-manual)
    ((("tmp" "temp")
      "temporary")
     dp-manual)
    ((("eof" "EOF")
      "EOF" "end of file")
     dp-manual)
    ((("hud" "Hud")
      "HUD" "head's up display")
     dp-manual global)
    ((("npc" "Npc")
      "NPC" "non-player character")
     dp-manual global)
    (("lang" "language")
     dp-manual global)
    (("vv" "virtual void" "virtual")
     dp-manual global)
    (("vb" "virtual bool" "virtual")
     dp-manual global)
    (("v" "virtual")
     dp-manual global)
    (("src" "source" "sources")
     dp-manual)
    ((("hie" "hier")
      "hierarchy")
     dp-manual)
    ((("bcbs" "BCBS")
      "Blue Cross Blue Shield")
     dp-manual)
    (("pvt" "priv" "private" "private:" "private")
     dp-manual)
    (("prot" "protected:" "protect" "protected")
     dp-manual)
    ((("dep" "deps")
      "dependency" "dependencies")
     dp-manual)
    (("foriegn" "foreign")
     dp-manual global)
    ((("lib" "libs")
      "library" "libraries"))
    (("buncha" "bunch of")
     dp-manual)
    (("TMMW" "to make matters worse")
     dp-manual global)
    (("med" "medication" "medications")
     dp-manual)
    ((("imo" "IMO")
      "in my opinion" "In my opinion" "im my humble opinion" 
      "In my humble opinion"))
    ((("imho" "IMHO")
      "im my humble opinion" "In my humble opinion" "in my opinion" 
      "In my opinion")
     dp-manual)
    (("PPT" "power of positive thinking")
     dp-manual)
    (("acet" "acetaminophen")
     dp-manual global)
    (("inv" "inventory")
     dp-manual)
    (("ooi" "out of inventory")
     dp-manual)
    (("combo" "combination")
     dp-manual)
    (("combo" "combination")
     dp-manual)
    (("mks" "makeshift")
     dp-manual)
    (("cons" "constructable")
     dp-manual)
    ((("fa" "forall") "\\-/")
     dp-manual)
    (("babs" "buildables")
     dp-manual)
    ((("sand" "land")
      "set and" "logical and" "intersection")
     dp-manual)
    ((("sf" "srcs" "chc")
      "*.[ch]*")
     dp-manual)
    (("arg" "argument" "arguments")
     dp-manual)
    (("args" "arguments" "argument")
     dp-manual)
    (("te" "there exists" "-]")
     dp-manual)
    (("hp" "hit points")
     dp-manual)
    (("ntms" "note to myself")
     dp-manual)
    (("pita" "pain in the ass")
     dp-manual)
    (("vp" "virtual Property_t")
     dp-manual)
    (("vaddr" "virtual address")
     dp-manual)
    (("paddr" "physical address")
     dp-manual)
    (("mem" "memory")
     dp-manual)
    (("FCFS" "first come first served")
     dp-manual)
    (("con" "concierge" "Concierge")
     dp-manual)
    (("metadata" "meta-data" "meta data")
     dp-manual)
    (("md" "metadata" "meta-data" "meta data")
     dp-manual)
    (("ccs" "const char* " "const std::string& ")
     dp-manual)
    ((("osr" "os") "std::ostream& os" "std::ostream& " "ostream& ")
     dp-manual)
    (("vvs" "const void* ")
     dp-manual)
    (("bg" "background")
     dp-manual)
    (("ascii" "ASCII")
     dp-manual)
    (("phr" "Prop_handler_ret_t")
     dp-manual)))
;; We could just use the non-void-ness of dp-common-abbrevs, but I
;; like suspenders with my belt.
(put 'dp-common-abbrevs 'dp-I-am-a-dp-style-abbrev-file t)
