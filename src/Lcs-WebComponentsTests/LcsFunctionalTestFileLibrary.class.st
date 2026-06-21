Class {
	#name : 'LcsFunctionalTestFileLibrary',
	#superclass : 'WAFileLibrary',
	#category : 'Lcs-WebComponentsTests-Libraries',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Libraries'
}

{ #category : 'as yet unclassified' }
LcsFunctionalTestFileLibrary class >> generateMainCss [
	^ self new generateMainCss
]

{ #category : 'as yet unclassified' }
LcsFunctionalTestFileLibrary class >> mainCss [
	^ self new generateMainCss
]

{ #category : 'css' }
LcsFunctionalTestFileLibrary >> applicationAreaCss [
	<css: 300>
^'.applicationArea {
	margin: 2px 2px 2px 2px;
	padding: 5px;
	border: 2px;
}'
]

{ #category : 'css' }
LcsFunctionalTestFileLibrary >> bodyCss [
	<css: 200>
^'body {
  font-family: Arial, Helvetica, sans-serif;
  margin: 0;
}'
]

{ #category : 'css' }
LcsFunctionalTestFileLibrary >> buttonBarCss [
	<css: 700>
^'.buttonBar {
	display: flex;
	gap: 3px;
}'
]

{ #category : 'css' }
LcsFunctionalTestFileLibrary >> buttonCss [
	<css: 1300>
^'.button {
  font-size:18px;
  font-weight:bold;
/*  position: fixed; */
  width: 100vw;
  box-shadow: 0 0 10px #e1e5ee;
  padding-right: 20px;
}'
]

{ #category : 'css - generate' }
LcsFunctionalTestFileLibrary >> cssPragmas [
	| pragmas |
	pragmas := OrderedCollection new.
	(Pragma pragmaCache at: #css:) 
		do: [:each |
			(each method isClassSide not and: [ each methodClass = self class ])
				ifTrue: [ pragmas add: each ] ].
	^ pragmas asSortedCollection: [ :a :b | a arguments last < b arguments last ]
]

{ #category : 'css - generate' }
LcsFunctionalTestFileLibrary >> generateMainCss [
	| stream |
	stream := WriteStream on: String new.
	stream
		nextPutAll: 'mainCss';
		cr;
		tab;
		nextPutAll: '"Generated: ' , DateAndTime now printString , '"';
		cr.
	stream
		tab;
		nextPutAll: '^ '''.
	self cssPragmas
		do: [ :each | 
			stream
				nextPutAll: '/*'; tab; nextPutAll: ('Source: #' , each methodSelector); tab; nextPutAll: '*/'; cr;
				nextPutAll: (LcsFunctionalTestFileLibrary new perform: each methodSelector) ]
		separatedBy: [ stream
				cr;
				cr ].
	stream nextPut: $'.
	self class compile: stream contents.
	^ stream contents
]

{ #category : 'css' }
LcsFunctionalTestFileLibrary >> globalCss [
	<css: 100>
	"This forces the padding and margin to be zero. 
	It overrides the browser defaults.
	Also, all component sizes are defined by width and heigth with the padding, border, and margin
	taken from inside the width and height. This is in contrast to 'content-box' where the padding,
	border, and margins are added to the hieght and width."
	
	^'
*,
*::before,
*::after {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}'
]

{ #category : 'css' }
LcsFunctionalTestFileLibrary >> labelAndInputRowCss [
	<css: 500>
^'.labelAndInputRow {
	display: grid;
	grid-auto-flow: column;
	grid-template-columns: 1fr 12rem;
	grid-column-gap: 0.1rem;
}'
]

{ #category : 'css' }
LcsFunctionalTestFileLibrary >> mainCss [
	"Generated: 2026-06-18T12:45:13.732463-04:00"
	^ '/*	Source: #globalCss	*/

*,
*::before,
*::after {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

/*	Source: #bodyCss	*/
body {
  font-family: Arial, Helvetica, sans-serif;
  margin: 0;
}

/*	Source: #applicationAreaCss	*/
.applicationArea {
	margin: 2px 2px 2px 2px;
	padding: 5px;
	border: 2px;
}

/*	Source: #twoColumnsBySixRowsCss	*/
.twoColumnsBySixRows {
  display: grid;
  grid-template-columns: 20rem 20rem;
  grid-template-rows: auto auto auto auto auto auto;
  grid-auto-flow: column;
  grid-row-gap: 0.2rem;
  grid-column-gap: 0.5rem;
}

/*	Source: #labelAndInputRowCss	*/
.labelAndInputRow {
	display: grid;
	grid-auto-flow: column;
	grid-template-columns: 1fr 12rem;
	grid-column-gap: 0.1rem;
}

/*	Source: #radioButtonAndLabelCss	*/
.radioButtonAndLabel {
  display: flex;
  align-items: center;
  gap: 3px;
}

/*	Source: #buttonBarCss	*/
.buttonBar {
	display: flex;
	gap: 3px;
}

/*	Source: #pushButtonCss	*/
.pushButton {
  display: flex;
  align-items: center;
  min-width: 5rem;
}

/*	Source: #radioButtonsCss	*/
.radioButtons {
  display: grid;
  grid-template-columns: 20px 1fr;
  gap: 2px;
  }

/*	Source: #mainMenuBarCss	*/
.mainMenuBar {
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
    padding: 0.5em;
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
}

.menuItemButton {
	text-decoration: none;
	background: none;
	border: none;
}
		
.menuItemButtonLabel {
	text-decoration: none;
	background: none;
	border: none;
}

/*	Source: #radioButtonsCss	*/
.radioButtons {
  display: grid;
  grid-template-columns: 20px 1fr;
  gap: 2px;
  }

/*	Source: #submenuCss	*/
.submenu {
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

/*--- Sublevel ULs display and position on hover ---*/
.mainMenuBarContents li:hover ul {
   opacity:1;
   transition: opacity 1s;
   } 

/*	Source: #subSubmenuCss	*/
/* had to make the position NOT based on hover, but permanent for the transition to work , thus moved it from POS_001 */
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


/*	Source: #buttonCss	*/
.button {
  font-size:18px;
  font-weight:bold;
/*  position: fixed; */
  width: 100vw;
  box-shadow: 0 0 10px #e1e5ee;
  padding-right: 20px;
}'
]

{ #category : 'css' }
LcsFunctionalTestFileLibrary >> mainMenuBarCss [
	<css: 1000>
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
    padding: 0.5em;
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
}

.menuItemButton {
	text-decoration: none;
	background: none;
	border: none;
}
		
.menuItemButtonLabel {
	text-decoration: none;
	background: none;
	border: none;
}'
 

]

{ #category : 'css' }
LcsFunctionalTestFileLibrary >> pushButtonCss [
	<css: 800>
^ '.pushButton {
  display: flex;
  align-items: center;
  min-width: 5rem;
}'
]

{ #category : 'css' }
LcsFunctionalTestFileLibrary >> radioButtonAndLabelCss [
	<css: 600>
^ '.radioButtonAndLabel {
  display: flex;
  align-items: center;
  gap: 3px;
}'
]

{ #category : 'css' }
LcsFunctionalTestFileLibrary >> radioButtonsCss [
	<css: 900>
	^'.radioButtons {
  display: grid;
  grid-template-columns: 20px 1fr;
  gap: 2px;
  }'
]

{ #category : 'css' }
LcsFunctionalTestFileLibrary >> subSubmenuCss [
	<css: 1200>
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

{ #category : 'css' }
LcsFunctionalTestFileLibrary >> submenuCss [
	<css: 1100>
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

/*--- Sublevel ULs display and position on hover ---*/
.mainMenuBarContents li:hover ul {
   opacity:1;
   transition: opacity 1s;
   } '
 

]

{ #category : 'css' }
LcsFunctionalTestFileLibrary >> twoColumnsBySixRowsCss [
	<css: 400>
^'.twoColumnsBySixRows {
  display: grid;
  grid-template-columns: 20rem 20rem;
  grid-template-rows: auto auto auto auto auto auto;
  grid-auto-flow: column;
  grid-row-gap: 0.2rem;
  grid-column-gap: 0.5rem;
}'
]
