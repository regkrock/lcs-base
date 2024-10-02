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
    
.mainMenuItem:hover {background: green ;} /* When hovering, the menu item bacground is set */

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

.submenuItem:hover {background: blue;}

  
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

{ #category : #'as yet unclassified' }
LcsFileLibrary >> mainCss0 [
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

.mainMenuContents {
  display: flex;
  justify-content: flex-start; /* should be flex-end */
  align-items: center;
  gap: 2rem;
  margin: 0 2rem;
    }

.mainMenuItem {
    display:inline-block;
    position:relative;
    float:left;
    text-wrap: nowrap;
    }

/* .mainMenuItem a { */
/*    display:inline-block; */
/*    width:200px; */
/*    line-height:35px; */
/*    padding:0; */
/*    text-decoration:none; */
/*    color:#ffffff; */
/*    } */
 
.mainMenuContents li li a {
    display:block;
    font-size:12px;
    
    opacity:1;
    transition: opacity 1s;
}
    
/* this is the background of the selected menu item - #003f20*/
.mainMenuContents li:hover {background: #f06292 ;} 

/*--- Sublist Styles ---*/
.mainMenuContents ul {
/* .submenu { */
  position:absolute;
  padding:0px;
  left:0;
  /* display:none; */
  opacity:0;
  transition: opacity 1s;
}

/*--- Hide Sub Sublists ---*/
.mainMenuContents li:hover ul ul {
    /* display:none; */
    opacity:0;
    transition: opacity 1s;
}

/*--- Sublevel UL''s display and position on hover ---*/
.mainMenuContents li:hover ul {
   /* display:block; */
   opacity:1;
   transition: opacity 1s;
   } 
   
/* had to make the position NOT based on hover, but permanent 
for the transition to work , thus moved it from POS_001 */
.mainMenuContents li li ul {
   margin-left:200px;
   margin-top:-35px;

}

.mainMenuContents li li:hover ul {
   /* POS_001 */

   
   /* display:block; */
   opacity:1;
   transition: opacity 1s;
}'
]

{ #category : #'as yet unclassified' }
LcsFileLibrary >> mainCss1 [
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

/* nav - top navigation bar - this styles the bos */
.nav {
  position: fixed;
  width: 100vw;
  box-shadow: 0 0 10px #e1e5ee;
  padding-right: 20px;
}

/* nav ul - this styles the menu labels inside the nav bar */
.nav__list {
  display: flex;
  justify-content: flex-end;
  align-items: center;
  gap: 2rem;
  margin: 0 2rem;
 }
.nav__listlogo {
  list-style: none;
  margin-right: auto;
  cursor: pointer;
}
.nav__listlogo svg {
  width: 2.5rem;
  transition: fill 250ms ease-in;
}
.nav__listlogo svg:hover, .nav__listlogo svg:focus {
  fill: #f06292;
}

/* nav ul li <- This styles the menu label */
.nav__listitem {
  list-style: none;
  font-weight: bold;
  position: relative;
  padding: 1.5rem 1rem;
  cursor: pointer;
}
/* ==== This is code for the underlining of the selectd menu item ==== */
/* In CSS, ::after creates a pseudo-element that is the last child of the selected element.  */
/*   It is often used to add cosmetic content to an element with the content property. It is inline by default. */
/* This defines the underline of the item when it is hovered over - the underline appears */
.nav__listitem::after {
  content: "";
  width: 0;
  height: 0.3rem;
  border-radius: 0.2rem;
  position: absolute;
  left: 1rem;
  bottom: 0.8rem;
  background-color: #f06292;
  transition: width 200ms ease-in;
}
.nav__listitem:hover::after, .nav__listitem:focus::after {
  width: 80%;
}
.nav__listitem:hover ul, .nav__listitem:focus ul {
  opacity: 1;
  visibility: visible;
}
/*==========*/
.nav__listitemdrop {
  position: absolute;
  top: 4rem;
  left: -1rem;
  box-shadow: 0 0 10px #e1e5ee;åç
  background-color: white;
  border-radius: 0.2rem;
  width: 12rem;
  padding: 1rem;
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
  opacity: 0;
  visibility: hidden;
  transition: opacity 200ms ease-in-out;
}
.nav__listitemdrop li {
  list-style: none;
  padding: 0.5rem 1rem;
  border-radius: 0.2rem;
  transition: background-color 200ms ease-in-out;
}
.nav__listitemdrop li:hover, .nav__listitemdrop li:focus {
  background-color: green "#fce4ec";
}


'
]
