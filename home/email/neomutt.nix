{
  programs.neomutt = {
    enable = true;
    extraConfig = ''
      set sort=threads
      set sort_aux=reverse-last-date-received

      # basic colors ---------------------------------------------------------
      color normal        color241        color234
      color error         color160        color234
      color tilde         color235        color234
      color message       color37         color234
      color markers       color160        color254
      color attachment    color254        color234
      color search        color61         color234
      #color status        J_black         J_status
      color status        color241        color235
      color indicator     color234        color136
      color tree          color136        color234                                    # arrow in threads

      # basic monocolor screen
      mono  bold          bold
      mono  underline     underline
      mono  indicator     reverse
      mono  error         bold

      # index ----------------------------------------------------------------

      #color index         color160        color234        "~D(!~p|~p)"               # deleted
      #color index         color235        color234        ~F                         # flagged
      #color index         color166        color234        ~=                         # duplicate messages
      #color index         color240        color234        "~A!~N!~T!~p!~Q!~F!~D!~P"  # the rest
      #color index         J_base          color234        "~A~N!~T!~p!~Q!~F!~D"      # the rest, new
      color index         color160        color234        "~A"                        # all messages
      color index         color166        color234        "~E"                        # expired messages
      color index         color33         color234        "~N"                        # new messages
      color index         color33         color234        "~O"                        # old messages
      color index         color61         color234        "~Q"                        # messages that have been replied to
      color index         color240        color234        "~R"                        # read messages
      color index         color33         color234        "~U"                        # unread messages
      color index         color33         color234        "~U~$"                      # unread, unreferenced messages
      color index         color241        color234        "~v"                        # messages part of a collapsed thread
      color index         color241        color234        "~P"                        # messages from me
      color index         color37         color234        "~p!~F"                     # messages to me
      color index         color37         color234        "~N~p!~F"                   # new messages to me
      color index         color37         color234        "~U~p!~F"                   # unread messages to me
      color index         color240        color234        "~R~p!~F"                   # messages to me
      color index         color160        color234        "~F"                        # flagged messages
      color index         color160        color234        "~F~p"                      # flagged messages to me
      color index         color160        color234        "~N~F"                      # new flagged messages
      color index         color160        color234        "~N~F~p"                    # new flagged messages to me
      color index         color160        color234        "~U~F~p"                    # new flagged messages to me
      color index         color235        color160        "~D"                        # deleted messages
      color index         color245        color234        "~v~(!~N)"                  # collapsed thread with no unread
      color index         color136        color234        "~v~(~N)"                   # collapsed thread with some unread
      color index         color64         color234        "~N~v~(~N)"                 # collapsed thread with unread parent
      # statusbg used to indicated flagged when foreground color shows other status
      # for collapsed thread
      color index         color160        color235        "~v~(~F)!~N"                # collapsed thread with flagged, no unread
      color index         color136        color235        "~v~(~F~N)"                 # collapsed thread with some unread & flagged
      color index         color64         color235        "~N~v~(~F~N)"               # collapsed thread with unread parent & flagged
      color index         color64         color235        "~N~v~(~F)"                 # collapsed thread with unread parent, no unread inside, but some flagged
      color index         color37         color235        "~v~(~p)"                   # collapsed thread with unread parent, no unread inside, some to me directly
      color index         color136        color160        "~v~(~D)"                   # thread with deleted (doesn't differentiate between all or partial)
      #color index         color136        color234        "~(~N)"                    # messages in threads with some unread
      #color index         color64         color234        "~S"                       # superseded messages
      #color index         color160        color234        "~T"                       # tagged messages
      #color index         color166        color160        "~="                       # duplicated messages

      # message headers ------------------------------------------------------

      #color header        color240        color234        "^"
      color hdrdefault    color240        color234
      color header        color241        color234        "^(From)"
      color header        color33         color234        "^(Subject)"

      # body -----------------------------------------------------------------

      color quoted        color33         color234
      color quoted1       color37         color234
      color quoted2       color136        color234
      color quoted3       color160        color234
      color quoted4       color166        color234

      color signature     color240        color234
      color bold          color235        color234
      color underline     color235        color234
      color normal        color244        color234
      #
      color body          color245        color234        "[;:][-o][)/(|]"    # emoticons
      color body          color245        color234        "[;:][)(|]"         # emoticons
      color body          color245        color234        "[*]?((N)?ACK|CU|LOL|SCNR|BRB|BTW|CWYL|\
                                                           |FWIW|vbg|GD&R|HTH|HTHBE|IMHO|IMNSHO|\
                                                           |IRL|RTFM|ROTFL|ROFL|YMMV)[*]?"
      color body          color245        color234        "[ ][*][^*]*[*][ ]?" # more emoticon?
      color body          color245        color234        "[ ]?[*][^*]*[*][ ]" # more emoticon?

      ## pgp

      color body          color160        color234        "(BAD signature)"
      color body          color37         color234        "(Good signature)"
      color body          color234        color234        "^gpg: Good signature .*"
      color body          color241        color234        "^gpg: "
      color body          color241        color160        "^gpg: BAD signature from.*"
      mono  body          bold                            "^gpg: Good signature"
      mono  body          bold                            "^gpg: BAD signature from.*"
    '';
  };
}
