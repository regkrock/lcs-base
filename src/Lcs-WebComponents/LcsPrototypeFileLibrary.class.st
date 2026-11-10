Class {
	#name : 'LcsPrototypeFileLibrary',
	#superclass : 'LcsBaseFileLibrary',
	#category : 'Lcs-WebComponents-Libraries',
	#package : 'Lcs-WebComponents',
	#tag : 'Libraries'
}

{ #category : 'html page' }
LcsPrototypeFileLibrary >> homePageText [
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

{ #category : 'css' }
LcsPrototypeFileLibrary >> mainCss [
	"LcsPrototypeFileLibrary new mainCss"
	| stream |
	stream := WriteStream on: String new.
	"stream nextPutAll: self resetCss."
	stream nextPutAll: self mainCss_base.
	stream nextPutAll: self navigationMenuCss.
	stream nextPutAll: self socialMediaCss.
	^ stream contents

]

{ #category : 'css' }
LcsPrototypeFileLibrary >> mainCss_base [
	^
'/* @font-face{
	font-family: Roboto;
	src: url(Roboto-Regular.ttf);
	};
@font-face{
	font-family: RobotoMedium;
	url: LcsFileLibrary / #RobotoMediumTtf;
	};
@font-face{
	font-family: RobotoBold;
	src: LcsFileLibrary / #RobotoBoldTtf;
	}; */
:root {
	--menu-count: 3;
	}
.root {
	font-family: Arial, Helvetica, sans-serif;
	background-color: #777;
	width: 100%;
	}
body{
	}
.mobile-menu-btn {
	display: none;
	}
/* pageHeader  */
.topHeader {
	height: 60px;
	top: 0;
	z-index: 100; /*forces header to always be on top*/
	}
'
]

{ #category : 'javascript' }
LcsPrototypeFileLibrary >> mobileNavJs [
	^ 'let headerMain = document.querySelector(".topHeader")
let headerMobileBtn = document.querySelector(".mobile-menu-btn");
let isMenuOpen = false;
headerMobileBtn.onClick = function() {
	if (!isMenuOpen.onclick) {
		header.Main.style.dispal = "flex";
		isMenuOpen = true;
	}
	else if (isMenuOpen) {
		header.Main.style.dispal = "none";
		isMenuOpen = false;
		}
}'
]

{ #category : 'css' }
LcsPrototypeFileLibrary >> navigationMenuCss [
^'/* --- Navbar Styling --- */
.navbar {
  /*background-color: #1a1a2e;*/
  /*color: #ffffff;*/
  position: relative;
  z-index: 1000;
}

.nav-container {
  /* max-width: 1200px; */
  margin: 0 auto;
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0 20px;
  height: 60px;
}
.topHeader .brand {
	align-items: center;
	display: flex;
	font-size: 1.5em;
	font-weight: 700;
	white-space: nowrap;
	gap: 0.1em;
	}
.logo {
	height: 40px;
	width: fit-content;
	align-self: center;
	cursor: pointer;
	min-width: 50px;
	
	& .logoImage {
		height: 100%;
		}
	}

/* --- Navigation Base --- */
.nav-menu {
  display: flex;
  list-style: none;
}

.nav-item {
  position: relative;
}

.nav-menu a {
  display: block;
  /* --- color: #ffffff; --- */
  white-space: nowrap;
  text-decoration: none;
  padding: 20px;
  transition: background 0.3s;
}

.nav-menu a:hover {
  background-color: #999999;
}

.arrow {
  font-size: 10px;
  margin-left: 5px;
  display: inline-block;
}

/* --- Submenu Setup (Desktop Layout) --- */
.submenu {
  display: none;
  position: absolute;
  top: 100%;
  left: 0;
  background-color: #777777;
  min-width: 200px;
  box-shadow: 0 8px 16px rgba(0,0,0,0.2);
  list-style: none;
}

/* Nested submenus shift to the right */
.submenu .submenu {
  top: 0;
  left: 100%;
  background-color: #777777;
}

/* Hover triggers to reveal deep submenus */
.nav-menu li:hover > .submenu {
  display: block;
}

/* --- Mobile Toggle Implementation --- */
.menu-toggle-checkbox {
  display: none;
}

.hamburger {
  display: none;
  cursor: pointer;
  flex-direction: column;
  gap: 5px;
}

.hamburger span {
  display: block;
  width: 25px;
  height: 3px;
  background-color: white;
  transition: 0.3s;
}

/* --- Responsive Media Query (Max-Width: 768px) --- */
@media (max-width: 768px) {
  .hamburger {
    display: flex;
  }

  /* Transform top menu into an accordion panel drawer */
  .nav-menu {
    display: none;
    position: absolute;
    top: 100%;
    left: 0;
    width: 100%;
    background-color: #aaaaaa;
    flex-direction: column;
    max-height: 80vh;
    overflow-y: auto;
  }

  /* Checkbox hack to reveal mobile navbar drawer */
  .menu-toggle-checkbox:checked ~ .nav-menu {
    display: flex;
  }

  /* Animate hamburger to an ''X'' shape when active */
  .menu-toggle-checkbox:checked ~ .hamburger span:nth-child(1) {
    transform: rotate(45deg) translate(5px, 5px);
  }
  .menu-toggle-checkbox:checked ~ .hamburger span:nth-child(2) {
    opacity: 0;
  }
  .menu-toggle-checkbox:checked ~ .hamburger span:nth-child(3) {
    transform: rotate(-45deg) translate(6px, -6px);
  }

  /* Make submenus stack inline vertically on mobile */
  .submenu, .submenu .submenu {
    position: static;
    width: 100%;
    box-shadow: none;
    background-color: #aaaaaa;
    padding-left: 15px; /* Indent submenus */
  }

  /* Change arrows to point down for mobile expansion layout */
  .has-submenu a .arrow {
    transform: rotate(270deg);
  }
}
'
]

{ #category : 'css' }
LcsPrototypeFileLibrary >> navigationMenuCss_2 [
^'/* <nav> tag which is like an <ul> */
.navBar {
	display: flex;
	align-items: center;
	justify-content: space-between;
	/* color: #fff;
	background: #333; */
	padding: 0.75rem 1rem;
	}
.logo {
	height: 40px;
	width: fit-content;
	align-self: center;
	cursor: pointer;
	
	& .logoImage {
		height: 100%;
		}
	}

/* child of <nav> - mainMenu */
.mainMenu {
	height: 100%;
	padding-left: 40px;
	list-style: none;
	display: flex;
	gap: 10px;
	align-self: center;
	line-height: 60px;
	align-items: center;
	}
.menuItem {
	display: flex;
	align-items: center;
	padding: 0 10px; 
	padding-left: 40px;
	line-height: 60px;
	position: relative;

	&:hover>ul {
		/* makes the submenu visibile when it is hovered over */
		visibility: visible;
		opacity: 1;
		display: block;
		}
		
	span {
		display: block;
		padding: 0 10px; 
		height: 100%;
		line-height: 60px;
		font-size: 1rem;
		font-family: RobotoMedium;
		color: #000000;
		background-color: #fff;
		text-transform: uppercase;
		cursor: pointer;
		transition: all ease-in-out 100ms;
		
		&:hover {
			background-color: #2a2a2a;
			color: #fff;
			}
		}
	}

.submenu {
	/* submenu is hidden by default, only visible when menuItem is hovered over */
	visibility: hidden;
	opacity: 0;
	display: none;
	position: absolute;
	top: 100%;
	left: 80px;
	transition: all ease-in-out 100ms;

	&:hover>ul {
		/* makes the submenu visibile when it is hovered over */
		visibility: visible;
		opacity: 1;
		display: block;
		}

	& span {
		white-space: nowrap;
		}
	}
	
/* contains the search form and the sm icons container */
.topHeader .sm {
	align-self: center;
	display: flex;
	}
/* search form */
.topHeader form {
	height: 40px;
	padding-right: 5px;
	display: flex;
	border: 1px solid #aeaeae;
	border-radius: 20px 100px 100px 20px;
	width: fit-content;
	align-self: center;
	
	& input {
		height: 100%;
		width: 300px;
		padding: 0 10px 0 20px;
		border-radius: 5px;
		font-size: 1rem;	
		font-family: Roboto;
		
		&:focus {
			border: 1px solid #111;
			}
		}
	& button {
		width: fit-content;
		padding: 5px 5px 0 10px;
		
		& img {
			height: 24px;
			padding-top: 15%;
			cursor: pointer;
			}
		}
	}

/* contains the sm icons with their links to the social media */
.topHeader .sm-links {
	height: 60px;
	width: fit-content;
	display: flex;
	align-items: center;
	
	& a {
		height: 30px;
		margin-left: 10px;
		cursor: pointer;
		align-items: center;
		
		& img {
			height: 100%;
			}
		}
	}
	
/* MEDIA QUERY FOR MOBILE DEVICE (PHONE) */

@media only screen and (max-width: 600px) {
/*	.topHeader {
		display: none;
		}
	.mobile-menu-btn {
		display: flex;
		justify-content: center;
		widht: 60px;
		height: 60px;
		position: absolute;
		top: 0;
		right: 0;
		z-index: 200;
		background-color: #fff;
		
		& img {
			height: 80%;
			align-self: center;
			} 
		}  */
	.topHeader {
		height: 100vh;
		flex-wrap: wrap;
		flex-direction: column;
		padding: 0;
		justify-content: flex-start;
		}
	.navBar {
		width: 100%;
		/* menu gets 80% of view height, social media get 20% */
		height: 80vh;
		flex-wrap: wrap;
		flex-direction: column;
		align-content: stretch;
		/* scroll down, but not sideways */
		overflow-y: scroll;
		overflow-y: hidden;
		}
	.topHeader .logo {
		height: 30%;
		padding: 0;
		margin: 0;
		display: flex;
		align-items: center;
		
		& .logoImage {
			height: 60%;
			align-self: center;
			}
		}
	.mainMenu {
		height: 70%;
		width: 100%;
		padding: 0;
		flex-wrap: wrap;
		flex-direction: column;
		align-content: space-between;
		
		&:nth-last-child(1) {
			border-bottom: 1px solid #ddd
			}
		}
	.menuItem {
		/* item goes from one edge to the other */
		width: 100%;
		height: calc(100% / var(--men-count));
		padding: 0;
		margin: 0;
		border-top: 1px solid #ddd;
		/* We set a flex here, with nowrap and column, to make
		the dropdown go below, and justify-content instaead since we
		are using column, to center the text */
		display: flex;
		flex-wrap: nowrap;
		flex-direction: column;
		justify-content: center;
		transition: all ease-in-out 100ms;

		&:hover>ul {
			/* makes the submenu visibile when it is hovered over */
			visibility: visible;
			opacity: 1;
			display: flex;
			}

		&:focus>ul {
			/* makes the submenu visibile when it has focus */
			visibility: visible;
			opacity: 1;
			display: flex;
			}

		& span {
			width: 100%;
			height: fit-content;
			padding: 0;
			margin: 0;
			text-align: center;
			font-size: 2.5rem;
			
			&:hover {
				/* this is to prevent hover effect */
				background-color: transparent;
				color: #111;
				}
			}
		}
	.submenu {
		display: none;
		flex-wrap: nowrap;
		flex-direction: column;
		position: absolute;
		top: 0;
		left: 0;
		z-index: 200;
		}
	.submenuItem {
		height: fit-content;
		display: block;
		background-color: #111;

		&:hover>ul {
			/* makes the submenu visibile when it is hovered over */
			visibility: visible;
			opacity: 1;
			display: flex;
			}

		& span {
			background-color: #111;
			color: #fff;
			
			&:hover {
				background-color: #111;
				color: #fff;
				}
			}
		}
	.topHeader .sm {
		width: 100%;
		height: 20vh;
		margin: 0;
		padding: 0;
		flex-wrap: wrap;
		flex-direction: column;
		align-items: center;
		}
	.topHeader form {
		padding-right: 0;
		width: 90%;
		height: 40%;
		
		& input {
			width: 100%;
			height: 100%;
			padding: 0 10px 0 20px;
			font-size: 1.6rem;
			}
		& button {
			padding: 0 5%;
			
			& img {
				height: 5vh;
				padding-top: 15%;
				}
			}
		}
	.top-header .sm-links {
		height: 50%;
		width: 100%;
		margin: 0;
		padding: 0;
		justify-content: center;
		
		& a {
			height: 60%;
			margin: 0 2%;
			padding: 0;
			}
		}
	}''X'' shape when active */
  .menu-toggle-checkbox:checked ~ .hamburger span:nth-child(1) {
    transform: rotate(45deg) translate(5px, 5px);
  }
  .menu-toggle-checkbox:checked ~ .hamburger span:nth-child(2) {
    opacity: 0;
  }
  .menu-toggle-checkbox:checked ~ .hamburger span:nth-child(3) {
    transform: rotate(-45deg) translate(6px, -6px);
  }

  /* Make submenus stack inline vertically on mobile */
  .submenu, .submenu .submenu {
    position: static;
    width: 100%;
    box-shadow: none;
    background-color: #162447;
    padding-left: 15px; /* Indent submenus */
  }

  /* Change arrows to point down for mobile expansion layout */
  .has-submenu a .arrow {
    transform: rotate(90deg);
  }
}
'
]

{ #category : 'css' }
LcsPrototypeFileLibrary >> sampleCss [
	<css: 2>
]

{ #category : 'html fragments' }
LcsPrototypeFileLibrary >> seasMonmouthHomePage [
^'
<h1>Seas Monmouth</h1>

<h2>Our Mission<h2>

<p>Welocme to SEAS Monmouth. We are a member of SEAS - The Society for the Education of American Sailors. SEAS was founded to promote and encourage small craft sailing activity as recreation and sport by providing low-cost learn-to-sail programs, and by encouraging relationships among all persons interested in sailing craft and water safety.</p>

<h3>How we accomplish our mission</h3>

<p>The Monmouth Chapter of SEAS is a non-profit organization. Monthly meetings are held at the Keyport Yacht Club in Keyport, NJ (see Locations and Directions for details) on the last Tuesday of each month with entertaining and informative speakers. Weekly sailing activities are scheduled throughout the summer season at our different locations. Our chapter runs a full range of sailing courses from basic through advanced, including cruising. Our fleet consists of six Olympic Class Lasers on the Shrewsbury River, four day sailers ranging in length from 17'' to 18'' in a marina on the Shrewsbury, a Capri 22'' keel-centerboard sloop in Atlantic Highlands, and a Catalina 30'' sloop with an inboard diesel engine and steering wheel in Keyport. This mix of boats allows our members to enjoy a variety of types of sailing and gain experience on different sized boats. Learn more at the local sailing page.</p>

<p>As a member you will receive emails at regular intervals from the organization with the latest news. Our calendars display the activities hosted by the organization. The organization depends on the donation of its members time to maintain the fleet, organize events to support the membership such as parties and other social activities, or serve on a committee, or as an elected board of trustee member. Each member is asked to donate four hours of their time over the year. "Many hands make light work" and it is a great way to meet new friends while completing a task. Many tasks require no skill, or may include learning a new skill from an experienced member. With a fleet this size, it takes many volunteer hours to prepare, maintain, repair, and winterize the boats.</p>

<p>We offer opportunities for members to grow their skills as crew, first mate, or skipper on SEAS boats. In addition we offer members opportunities in cruising. We cruise both near (Newport RI, Chesapeake Bay) and far (Caribbean, San Juan Islands, New Zealand and Tahiti are all destinations we''ve been to).</p>

<p>SEAS Monmouth Commodore</p>

<p>commodore@monmouth.sailseas.com</p>'

]

{ #category : 'css' }
LcsPrototypeFileLibrary >> socialMediaCss [
^'/* contains the search form and the sm icons container */
.topHeader .sm {
	align-self: center;
	display: flex;
	}
/* search form */
.topHeader form {
	height: 40px;
	padding-right: 5px;
	display: flex;
	border: 1px solid #aeaeae;
	border-radius: 20px 100px 100px 20px;
	width: fit-content;
	align-self: center;
	background: #ffffff;
	
	& input {
		height: 100%;
		width: 300px;
		padding: 0 10px 0 20px;
		border-radius: 5px;
		font-size: 1rem;	
		font-family: Roboto;
		
		&:focus {
			border: 1px solid #111;
			}
		}
	& button {
		width: fit-content;
		padding: 5px 5px 0 10px;
		
		& img {
			height: 24px;
			padding-top: 15%;
			cursor: pointer;
			}
		}
	}

/* contains the sm icons with their links to the social media */
.topHeader .sm-links {
	height: 60px;
	width: fit-content;
	display: flex;
	align-items: center;
	
	& a {
		display: flex;
		height: 30px;
		width: 30px;
		padding: 2px;
		/* margin-left: 10px; */
		cursor: pointer;
		align-items: center;
		
		& img {
			height: auto;
			}
		}
	}
@media (max-width: 768px) {
.topHeader .sm {
	padding-left: 15px;
	align-self: flex-start;
	}
}'
]
