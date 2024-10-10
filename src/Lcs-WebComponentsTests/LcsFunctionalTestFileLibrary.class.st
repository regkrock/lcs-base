Class {
	#name : #LcsFunctionalTestFileLibrary,
	#superclass : #WAFileLibrary,
	#category : #'Lcs-WebComponentsTests-Libraries'
}

{ #category : #'as yet unclassified' }
LcsFunctionalTestFileLibrary class >> mainCss [
	^ self new mainCss
]

{ #category : #css }
LcsFunctionalTestFileLibrary >> applicationAreaCss [

^'.applicationArea {
	margin: 2px 2px 2px 2px;
	padding: 5px;
	border: 2px;
}'
]

{ #category : #css }
LcsFunctionalTestFileLibrary >> bodyCss [
^'body {
  font-family: Arial, Helvetica, sans-serif;
  margin: 0;
}'
]

{ #category : #css }
LcsFunctionalTestFileLibrary >> globalCss [
^'
*,
*::before,
*::after {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}'
]

{ #category : #css }
LcsFunctionalTestFileLibrary >> mainCss [
	| stream |
	stream := WriteStream on: String new.
	#(globalCss bodyCss applicationAreaCss mainMenuBarCss #submenuCss subSubmenuCss) do: [:each |
		stream nextPutAll: (self perform: each asSymbol) ] separatedBy: [ stream cr; cr ].
	^ stream contents
]

{ #category : #css }
LcsFunctionalTestFileLibrary >> mainMenuBarCss [

^'.mainMenuBar {
  font-size:18px;
  font-weight:bold;
/*  position: fixed; */
  width: 100vw;
  box-shadow: 0 0 10px #e1e5ee;
  padding-right: 20px;

}

.mainMenuBarContents {
  display: flex;
  justify-content: flex-start; /* should be flex-end */
  align-items: center;
  gap: 2rem;
  margin: 0 2rem;
  height: 24px;
    }

.mainMenuItem {
    display:block;
    position:relative;
    float:left;
    text-wrap: nowrap;
    width: fit-content;
 /*   padding: 0.5em;  */
    }
    
.mainMenuItem:hover {
	background: lightGreen;
} /* When hovering, the menu item bacground is set */
    
.mainMenuItemButton {
  display:inline-block;
  width:100px;
 /* line-height:35px; */
  padding:2px;
  text-decoration:none;
  color:#000000;
}'
 

]

{ #category : #css }
LcsFunctionalTestFileLibrary >> subSubmenuCss [
^
'/* had to make the position NOT based on hover, but permanent for the transition to work , thus moved it from POS_001 */
.subsubmenu {
  display: flex;
  background-color: white;
  position: relative;
  margin-left: 2em;  /* This sets the distance of the submenu from its item */
  margin-top: 35px;
}

.mainMenuBarContents li li:hover ul { 
/* .mainMenuItem:hover li:hover ul {  */
  opacity:1;
  transition: opacity 1s;
}

/*--- Hide Sub Sublists ---*/
.mainMenuBarContents li:hover ul ul {
  opacity:0;
  transition: opacity 0s;
}
'
]

{ #category : #css }
LcsFunctionalTestFileLibrary >> submenuCss [
^'.submenu {
  display: block;
  position: absolute;
  flex-direction: column;
  opacity:0;
  transition: opacity 1s;
  background-color: white;
}

.submenu:hover {
  opacity:1;
  transition: opacity 1s;}

.submenuItem {
    display: inline-block;
    position: relative;
    font-size: 12px;
    "height: 35px;"
    align-items: center;
    width: 100px;
}

.submenuItem:hover {
	background: lightGreen;
}

.submenuItemButton {
  display:inline-block;
  font-size:12px;
  width:100px;
  line-height:35px;
  text-decoration:none;
  color:#000000;
  padding:0;
  width: 100%;
  opacity:1;
  transition: opacity 1s;
  margin: 0px 5px 0px 5px;}
 
.submenuItemButton:active {
  opacity:0;
  transition: opacity 1s;
 }

/*--- Sublevel UL''s display and position on hover ---*/
.mainMenuBarContents li:hover ul {
   opacity:1;
   transition: opacity 1s;
   } '
 

]
