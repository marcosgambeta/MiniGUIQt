/*

  MiniGUIQt - m�dulo para Qt4xHb/Qt5xHb com sintaxe no estilo MiniGUI

  Copyright (C) 2020 Marcos Antonio Gambeta <marcosgambeta AT outlook DOT com>

*/

#xcommand @ <nRow>,<nCol> COMBOBOX <name> [ OBJECT <oObj> ] ;
          [ <dummy1:OF,PARENT,DIALOG> <parent> ] ;
          [ WIDTH <nWidth> ] ;
          [ HEIGHT <nHeight> ] ;
          [ TOOLTIP <cToolTip> ] ;
          [ STATUSTIP <cStatusTip> ] ;
          [ WHATSTHIS <cWhatsThis> ] ;
          [ STYLESHEET <cStyleSheet> ] ;
          [ FONT <cFontName> ] ;
          [ SIZE <nFontSize> ] ;
          [ <lBold:BOLD> ] ;
          [ <lItalic:ITALIC> ] ;
          [ <lUnderline:UNDERLINE> ] ;
          [ <lStrikeout:STRIKEOUT> ] ;
          [ ITEMS <aItems> ] ;
          [ <lInvisible:INVISIBLE> ] ;
          [ <lDisabled:DISABLED> ] ;
          [ <lNoTabStop:NOTABSTOP> ] ;
          [ ON GOTFOCUS <bOnGotFocus> ] ;
          [ ON LOSTFOCUS <bOnLostFocus> ] ;
          [ <class:CLASS> <className> ] ;
          => ;
          HMGCore():addObject( [ <oObj> := ] __IIF(<.class.>,<className>,HMGComboBox)():new(;
          <"name">,;
          <"parent">,;
          <nCol>,;
          <nRow>,;
          <nWidth>,;
          <nHeight>,;
          <cToolTip>,;
          <cStatusTip>,;
          <cWhatsThis>,;
          <cStyleSheet>,;
          <cFontName>,;
          <nFontSize>,;
          <.lBold.>,;
          <.lItalic.>,;
          <.lUnderline.>,;
          <.lStrikeout.>,;
          <aItems>,;
          <.lInvisible.>,;
          <.lDisabled.>,;
          <.lNoTabStop.>,;
          <{bOnGotFocus}>,;
          <{bOnLostFocus}>;
          ) )
