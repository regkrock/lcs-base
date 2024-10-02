Class {
	#name : #LcsFileLibrary,
	#superclass : #WAFileLibrary,
	#category : #'Lcs-WebComponents-Libraries'
}

{ #category : #'as yet unclassified' }
LcsFileLibrary >> mainCss [
	^
'
*,
*::before,
*::after {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

body {
  font-family: Arial, Helvetica, sans-serif;
  margin: 0;
}

.mainMenuBar {
  font-size:18px;
  font-weight:bold;
  position: fixed;
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
    }

.mainMenuItem {
    display:block;
    position:relative;
    float:left;
    text-wrap: nowrap;
    width: fit-content
    }
    
.mainMenuItemButton {
  display:inline-block;
  width:100px;
  line-height:35px;
  padding:0;
  text-decoration:none;
  color:#000000;
  font-size: 1px;
}
 
.submenuItemButton {
  display:inline-block;
  font-size:12px;
  width:100px;
  line-height:35px;
  text-decoration:none;
  color:#000000;
  padding:0;
  opacity:1;
  transition: opacity 1s;
 }
    
.mainMenuItem:hover {background: lightGreen ;} /* When hovering, the menu item bacground is set */

/*--- Sublist Styles ---*/
.submenu {
  display: flex;
  position: absolute;
  flex-direction: column;
  opacity:0;
  transition: opacity 1s;}

.submenu:hover {
  opacity:1;
  transition: opacity 1s;}

.submenuItem {
    display: flex;
    position: relative;
    font-size: 12px;
    height: 35px;
    align-items: center;
    width: 100px;
}

.submenuItem:hover {background: lightGreen;}

  
/*--- Hide Sub Sublists ---*/
/* .mainMenuItem:hover  ul ul { */
.mainMenuBarContents li:hover ul ul {
  opacity:0;
  transition: opacity 0s;
}

/*--- Sublevel UL''s display and position on hover ---*/
.mainMenuBarContents li:hover ul {
   opacity:1;
   transition: opacity 1s;
   } 
   
/* had to make the position NOT based on hover, but permanent 
for the transition to work , thus moved it from POS_001 */
.subsubmenu {
  position: relative;
  margin-left: 2em;  /* This sets the distance of the submenu from its item */
  margin-top: 35px;
}

.mainMenuBarContents li li:hover ul { 
/* .mainMenuItem:hover li:hover ul {  */
  opacity:1;
  transition: opacity 1s;
}

 '
]
