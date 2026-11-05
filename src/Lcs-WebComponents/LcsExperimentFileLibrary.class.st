Class {
	#name : 'LcsExperimentFileLibrary',
	#superclass : 'LcsBaseFileLibrary',
	#category : 'Lcs-WebComponents-Libraries',
	#package : 'Lcs-WebComponents',
	#tag : 'Libraries'
}

{ #category : 'css' }
LcsExperimentFileLibrary >> mainCss [
	"This is the css used for the multi-level menu system with checkboxes"
	^'   body {
      font-family: sans-serif;
      background-color: #f4f4f4;
    }

    /* Navbar Container */
    .navbar {
      background-color: #333;
      color: #fff;
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 0 20px;
      position: relative;
      height: 60px;
      z-index: 100;
    }
    .brand {
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

    /* Navigation Links & Lists */
    .nav-links {
      display: flex;
      list-style: none;
    }
    .nav-item {
      position: relative;
    }
    .nav-item a, .nav-item label {
      display: block;
      padding: 20px;
      color: #fff;
      text-decoration: none;
      cursor: pointer;
    }
    .nav-item a:hover, .nav-item label:hover {
      background-color: #444;
    }

    /* Dropdown Logic (Desktop) */
    .submenu {
      display: none;
      position: absolute;
      top: 100%;
      left: 0;
      background-color: #444;
      list-style: none;
      min-width: 200px;
      box-shadow: 0 8px 16px rgba(0,0,0,0.2);
    }
    .submenu .submenu {
      top: 0;
      left: 100%;
      background-color: #555;
    }
    
    /* Desktop Hover Toggle & Layout Rules */
    @media (min-width: 769px) {
      .nav-item:hover > .submenu,
      .submenu-item:hover > .submenu {
        display: block;
      }
      .menu-toggle, .menu-btn, .submenu-toggle {
        display: none;
      }
      /* Desktop Layout: Flexible gap separates the arrow from the text label */
      .arrow-label {
        display: inline-flex;
        align-items: center;
        gap: 12px; 
      }
      .arrow-label::after {
        content: ''▼'';
        font-size: 0.55rem;
        transition: transform 0.2s ease;
      }
      /* Level 2+ Desktop Layout (nested sidebar dropdowns) */
      .submenu .arrow-label {
        display: flex;
        justify-content: space-between; 
        min-width: 100%;
      }
      .submenu .arrow-label::after {
        content: ''▶'';
      }
    }

    /* Mobile Responsive Layout (< 768px) */
    @media (max-width: 768px) {
      /* Hamburger Menu Icon */
      .menu-btn {
        display: block;
        font-size: 1.5rem;
        cursor: pointer;
        padding: 10px;
      }
      .nav-links {
        display: none;
        flex-direction: column;
        position: absolute;
        top: 100%;
        left: 0;
        width: 100%;
        background-color: #333;
        height: calc(100vh - 60px);
        overflow-y: auto;
      }
      
      .menu-toggle:checked ~ .nav-links {
        display: flex;
      }
      .nav-item {
        width: 100%;
      }

      /* Mobile Accordion Stack Setup */
      .submenu, .submenu .submenu {
        position: relative;
        top: 0;
        left: 0;
        width: 100%;
        box-shadow: none;
        background-color: rgba(0, 0, 0, 0.15);
      }

      /* Multi-level Mobile Indentation via CSS Variables */
      .nav-links a, .nav-links label {
        --depth-padding: 20px;
        padding-left: var(--depth-padding);
      }
      .submenu a, .submenu label {
        --depth-padding: 40px;
      }
      .submenu .submenu a, .submenu .submenu label {
        --depth-padding: 60px;
      }

      /* Mobile Layout: Automatically fill space, driving text left and arrow right */
      .arrow-label {
        display: flex;
        justify-content: space-between; 
        align-items: center;
      }
      .arrow-label::after {
        content: ''▼'';
        font-size: 0.65rem;
        padding-right: 20px;
        transition: transform 0.3s ease;
        transform: rotate(-90deg); /* Points right when closed */
      }

      /* Rotate Arrow down when matching checkbox is checked */
      .submenu-toggle:checked + .arrow-label::after {
        transform: rotate(0deg); /* Points down when opened */
      }

      /* Mobile Dropdown Visibility Toggle */
      .submenu-toggle:checked ~ .submenu {
        display: block;
      }
    }

    /* Hidden Utility Checkboxes for state management */
    .menu-toggle, .submenu-toggle {
      position: absolute;
      opacity: 0;
      z-index: -1;
      width: 0;
      height: 0;
    }'

]
