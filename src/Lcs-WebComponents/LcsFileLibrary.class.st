Class {
	#name : #LcsFileLibrary,
	#superclass : #WAFileLibrary,
	#category : #'Lcs-WebComponents-Libraries'
}

{ #category : #'as yet unclassified' }
LcsFileLibrary class >> mainCss2 [
	| object stream |
	stream := WriteStream on: String new.
	object := self new.
	object addCssDefinitionsTo: stream.
	^stream contents
	
]

{ #category : #css }
LcsFileLibrary >> addCssDefinitionsTo: aStream [
	aStream nextPutAll:
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
}'.

	#(mainMenuBarContentsCssClassDefinition mainMenuBarCssClassDefinition) 
		do: [:each | aStream nextPutAll: (self perform: each asSymbol) ]
		separatedBy: [aStream cr; cr ].
	"aStream nextPutAll: self mainMenuBarContentsCssClassDefinition.
	aStream nextPutAll: self mainMenuBarCssClassDefinition"
]

{ #category : #'html page' }
LcsFileLibrary >> homePageText [
^
'<div class="row">

  <div class="col-md-8">

    <div id="titlearea">

      <!-- place title here -->
      <br>
      <br>
      <h1>Welcome to the Monmouth chapter of SEAS</h1>

    </div>

  </div>

  <!-- Insert high-priority links here, e.g. keelboat campaign box -->
</div> <!--  end of row  -->

<!-- ################  END TITLE AND "LATEST NEWSLETTER" BOX AREA  #################### -->


<!-- ################  BEGIN CONTENT AREA  #################### -->

<div class="row">
  <!-- ####### main content areas:  "Welcome" and "Commodore''s message" ###### -->

  <div class="col-md-8">
    <h3>Our Mission</h3>
    <p>The Society for the Education of American Sailors, SEAS, was founded to promote and encourage small craft
      sailing activity as recreation and sport by providing low-cost learn-to-sail programs, and by encouraging
      relationships among all persons interested in sailing craft and water safety. </p>
    <h3>How we accomplish our mission</hs>
      <p>The Monmouth Chapter of SEAS is a non-profit organization. <a href="meetings.htm">Monthly meetings</a> are held at the Keyport Yacht Club in Keyport, NJ
      (see <a href="locations.htm">Locations and Directions</a> for details) on the last Tuesday of each month with
      entertaining and informative speakers. Weekly sailing activities are scheduled throughout the
      summer season at our different locations.  Our chapter runs a full range of sailing courses from basic through
      advanced, including cruising. Our fleet consists of six Olympic Class Lasers on the Shrewsbury River, four day
      sailers ranging in length from 17'' to 18'' in a marina on the Shrewsbury, a Capri 22'' keel-centerboard sloop in
      Atlantic Highlands, and a Catalina 30'' sloop with an inboard diesel engine and steering wheel in Keyport. This
      mix of boats allows our members to enjoy a variety of types of sailing and gain experience on different sized boats.
      Learn more at the <a href="localsailing.htm">local sailing page.</a>
    </p>


    <p>As a member you will receive emails at regular intervals from the organization with the latest news. Our
      calendars display the activities hosted by the organization. The organization depends on the donation of its
      members time to maintain the fleet, organize events to support the membership such as parties and other social
      activities, or serve on a committee, or as an elected board of trustee member. Each member is asked to donate
      four hours of their time over the year. "Many hands make light work" and it is a great way to meet new friends
      while completing a task. Many tasks require no skill, or may include learning a new skill from an experienced
      member. With a fleet this size, it takes many volunteer hours to prepare, maintain, repair, and winterize
      the boats.</p>

    <p>We offer opportunities for members to grow their skills as crew, first mate, or skipper on <a href="locations.htm">SEAS boats</a>. In addition
      we offer members opportunities in cruising. We cruise both near (Newport RI, Chesapeake Bay) and far (Caribbean, San Juan
      Islands, New Zealand and Tahiti are all destinations we''ve been to).
    </p>
    <p></p>
    <h4 style=" text-align: center;">SEAS Monmouth Commodore<h4>
    <p style="text-align: center;""> <a href="mailto=commodore@monmouth.sailseas.com">commodore@monmouth.sailseas.com</a> </p>
  </div>'
]

{ #category : #css }
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

.submenuItem:hover {
	background: lightGreen;
}

  
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

.applicationArea {
	margin: 2px 2px 2px 2px
}
 '
]

{ #category : #css }
LcsFileLibrary >> mainCss2 [
	| stream |
	stream := WriteStream on: String new.
	stream nextPutAll:
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
}'.

	#(mainMenuBarContentsCssClassDefinition mainMenuBarCssClassDefinition) 
		do: [:each | stream nextPutAll: (self perform: each asSymbol) ] separatedBy: [ stream cr; cr ].
	"stream nextPutAll: self mainMenuBarContentsCssClassDefinition.
	stream nextPutAll: self mainMenuBarCssClassDefinition."
	^ stream contents
]

{ #category : #css }
LcsFileLibrary >> mainMenuBarContentsCssClassDefinition [

^'.mainMenuBarContents {
  display: flex;
  justify-content: flex-start; /* should be flex-end */
  align-items: center;
  gap: 2rem;
  margin: 0 2rem;
    }'
]

{ #category : #css }
LcsFileLibrary >> mainMenuBarCssClassDefinition [
	^'.mainMenuBarContents {
  display: flex;
  justify-content: flex-start; /* should be flex-end */
  align-items: center;
  gap: 2rem;
  margin: 0 2rem;
    }'
]
