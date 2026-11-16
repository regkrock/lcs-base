Class {
	#name : 'LuiMainPageExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiMainPageExamples >> mainPage [
	<gtExample>
	| mainPageComponent headerComponent titleComponent navigationBar navigationMenu applicationAreaComponent |
	mainPageComponent := LuiFunctionalTestsMainPage new.
	
	self assert: (mainPageComponent isKindOf: LuiFunctionalTestsMainPage).
	self assert: mainPageComponent parentComponent isNil.

	headerComponent := mainPageComponent pageHeader.
	self assert: (mainPageComponent pageHeader isKindOf: LuiPageHeader).
	self assert: headerComponent parentComponent equals: mainPageComponent.
		
	titleComponent := headerComponent pageTitleComponent.
	titleComponent text: 'LCS Example'.
	self assert: titleComponent text equals: 'LCS Example'.
	self assert: (titleComponent isKindOf: LuiPageTitle).
	self assert: titleComponent parentComponent equals: headerComponent.

	navigationBar := mainPageComponent navigationBar.
	self assert: (navigationBar isKindOf: LuiNavigationBar).
	self assert: navigationBar parentComponent equals: mainPageComponent.
	
	navigationMenu := navigationBar navigationMenu.
	self assert: navigationMenu parentComponent equals: navigationBar.
	self assert: (navigationMenu isKindOf: LuiMenu).

	applicationAreaComponent := mainPageComponent applicationAreaComponent.
	self assert: applicationAreaComponent parentComponent equals: mainPageComponent.
	self assert: (applicationAreaComponent isKindOf: LuiHomeArea).

	^ mainPageComponent
]
