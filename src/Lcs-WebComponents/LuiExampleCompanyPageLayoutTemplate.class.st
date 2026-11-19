Class {
	#name : 'LuiExampleCompanyPageLayoutTemplate',
	#superclass : 'LuiStandardPageLayoutTemplate',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'menu  definitions' }
LuiExampleCompanyPageLayoutTemplate >> aboutContactItemDefinition [
	| item |
	^ (item := LuiMenuItem named: 'contactMenuItem')
		cssClass: LuiCssClassesMap / #'nav-item';
        beButtonType;
		buttonLabel: 'About';
		buttonOnClickExecute: [ item rootComponent switchMainComponentTo: self aboutPresenterDefinition]
			update: [ item rootComponent currentSwitchableComponent ]
			update: [ item rootComponent navigationBar ];
		title: 'Contact Menu Item';
		yourself
]

{ #category : 'presenter definitions' }
LuiExampleCompanyPageLayoutTemplate >> aboutPresenterDefinition [
	^ LuiMessagePresenter new
		componentName: 'aboutPresenter';
		message: 'About';
		yourself
]

{ #category : 'menu  definitions' }
LuiExampleCompanyPageLayoutTemplate >> aboutUsMenuItemDefinition [
	| item |
	^ (item :=  LuiMenuItem named: 'aboutUs')
		anchorLabel: 'About Us';
		cssClass: LuiCssClassesMap / #'submenu-item';
		callback: [  "Transcript cr; show: 'aboutUs clicked'."
			item rootComponent mainForm
				switchToComponent: (LuiMessagePresenter new
						componentName: 'aboutUsPresenter';
						message: 'Company ... About Us';
						yourself) ];
		yourself
]

{ #category : 'menu  definitions' }
LuiExampleCompanyPageLayoutTemplate >> careersMenuItemDefinition [
	| item |
	^ (item :=  LuiMenuItem named: 'careers')
		anchorLabel: 'Careers';
		cssClass: LuiCssClassesMap / #'submenu-item';
		callback: [  "Transcript cr; show: 'careers clicked'."
			item rootComponent mainForm
				switchToComponent: (LuiMessagePresenter new
						componentName: 'careersPresenter';
						message: 'Company ... Careers';
						yourself) ];
		yourself
]

{ #category : 'menu  definitions' }
LuiExampleCompanyPageLayoutTemplate >> contactSubenuComponentDefinition [
	^ ((LuiDropDownMenuItem named: 'company' label: 'Company')
		cssClass: 'nav-item';
		yourself)
			addMenuItem: self aboutUsMenuItemDefinition;
			addMenuItem: self careersMenuItemDefinition;
			addMenuItem: self ourTeamMenuItemDefinition;
			yourself
]

{ #category : 'menu  definitions' }
LuiExampleCompanyPageLayoutTemplate >> homeMenuItemComponentDefinition [
	| item |
	^ (item := LuiMenuItem named: 'homeMenuItem')
		cssClass: LuiCssClassesMap / #'nav-item';
		beButtonType;
		buttonLabel: 'Home';
		buttonOnClickExecute: [ item rootComponent switchMainComponentTo: self homePresenterDefinition]
			update: [ item rootComponent currentSwitchableComponent ]
			update: [ item rootComponent navigationBar ];
		title: 'Home Menu Item';
		yourself
]

{ #category : 'presenter definitions' }
LuiExampleCompanyPageLayoutTemplate >> homePresenterDefinition [
	^ LuiMessagePresenter new
		componentName: 'homePresenter';
		message: 'Home';
		yourself
]

{ #category : 'components - definition' }
LuiExampleCompanyPageLayoutTemplate >> navigationMenuDefinition [
	^ super navigationMenuDefinition
		addComponent: self homeMenuItemComponentDefinition;
		addComponent: self contactSubenuComponentDefinition;
		addComponent: self aboutContactItemDefinition;
		addComponent: self socialMediaBarComponentDefinition;
		yourself
]

{ #category : 'menu  definitions' }
LuiExampleCompanyPageLayoutTemplate >> ourTeamMenuItemDefinition [
	| item |
	^ (item :=  LuiMenuItem named: 'ourTeam')
		anchorLabel: 'Our Team';
		cssClass: LuiCssClassesMap / #'submenu-item';
		callback: [  "Transcript cr; show: 'our team clicked'."
			item rootComponent mainForm
				switchToComponent: (LuiMessagePresenter new
						componentName: 'ourteamPresenter';
						message: 'Company ... Our Team';
						yourself) ];
		yourself
]

{ #category : 'components - definition' }
LuiExampleCompanyPageLayoutTemplate >> socialMediaBarComponentDefinition [
	^ LuiSearchAndSocialMediaBar newSearchAndLinks
]
