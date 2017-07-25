/*

  MiniGUIQt - m�dulo para Qt4xHb/Qt5xHb com sintaxe no estilo MiniGUI

  Copyright (C) 2017 Marcos Antonio Gambeta <marcosgambeta AT outlook DOT com>

*/

#include "qt5xhb.ch"
#include "hbclass.ch"

//---------------------------------------------------------------------------//

CLASS HMGGrid INHERIT HMGWidget

   DATA oModel
   DATA aItems
   DATA aHeaders
   DATA aWidths

   METHOD new

ENDCLASS

//---------------------------------------------------------------------------//

METHOD new (cName,cParent,nX,nY,nWidth,nHeight,cToolTip,cStatusTip,cWhatsThis,cStyleSheet,;
            cFontName,nFontSize,lBold,lItalic,lUnderline,lStrikeOut,;
            aItems,aHeaders,aWidths,lInvisible,lDisabled,lNoTabStop,bOnGotFocus,bOnLostFocus) CLASS HMGGrid

   LOCAL oParent
   LOCAL n

   IF !empty(cParent)
      oParent := HMGCore():object(cParent)
   ENDIF

   ::cName := cName

   IF valtype(oParent) == "O"
      ::oQt := QTableView():new(oParent:oQt)
      ::cParentName := oParent:cName
   ELSE
      ::oQt := QTableView():new(HMGFILO():last():oQt)
      ::cParentName := HMGFILO():last():cName
   ENDIF

   ::lCharacters := HMGCore():object(::cParentName):lCharacters

   ::configFont(cFontName,nFontSize,lBold,lItalic,lUnderline,lStrikeOut)

   IF ::lCharacters
      oFontMetrics := QFontMetrics():new(QFont():new(::oQt:font()):setBold(.F.):setItalic(.F.):setUnderline(.F.):setStrikeOut(.F.))
      ::nCharWidth := oFontMetrics:averageCharWidth()
      ::nCharHeight := oFontMetrics:height()
      oFontMetrics:delete()
   ENDIF

   ::configGeometry(nX,nY,nWidth,nHeight)

   ::configTips(cToolTip,cStatusTip,cWhatsThis)

   IF valtype(cStyleSheet) == "C"
      ::oQt:setStyleSheet(cStyleSheet)
   ENDIF

   // itens
   IF valtype(aItems) == "A"
      ::aItems := aItems
   ELSE
      ::aItems := {}
   ENDIF

   // t�tulos dos cabe�alhos
   IF valtype(aHeaders) == "A"
      ::aHeaders := aHeaders
   ELSE
      ::aHeaders := {}
   ENDIF

   // largura das colunas
   IF valtype(aWidths) == "A"
      ::aWidths := aWidths
   ELSE
      ::aWidths := {}
   ENDIF

   // modelo
   ::oModel := HAbstractTableModel():new()
   ::oModel:setRowCountCB({||len(::aItems)})
   ::oModel:setColumnCountCB({||iif(len(::aItems)>0,len(::aItems[1]),0)})
   ::oModel:setDisplayRoleCB({|nRow,nCol|aItems[nRow+1,nCol+1]})
   ::oModel:setHorizontalHeaderDisplayRoleCB({|nCol|iif(len(::aHeaders)>=(nCol+1),::aHeaders[nCol+1],NIL)})
   ::oQt:setModel(::oModel)

   // define a largura (width) das colunas
   FOR n := 1 TO len(::aWidths)
      ::oQt:setColumnWidth(n-1,aWidths[n])
   NEXT N

   IF valtype(lInvisible) == "L"
      IF lInvisible
         ::oQt:setVisible(.F.)
      ENDIF
   ENDIF

   IF valtype(lDisabled) == "L"
      IF lDisabled
         ::oQt:setEnabled(.F.)
      ENDIF
   ENDIF

   IF valtype(lNoTabStop) == "L"
      IF lNoTabStop
         ::oQt:setFocusPolicy(Qt_NoFocus)
      ENDIF
   ENDIF

   IF valtype(bOnGotFocus) == "B"
      ::bOnFocusInEvent := bOnGotFocus
   ENDIF

   IF valtype(bOnLostFocus) == "B"
      ::bOnFocusOutEvent := bOnLostFocus
   ENDIF

   ::oQt:onFocusInEvent({||::onFocusInEvent(),.F.})
   ::oQt:onFocusOutEvent({||::onFocusOutEvent(),.F.})

RETURN self

//---------------------------------------------------------------------------//