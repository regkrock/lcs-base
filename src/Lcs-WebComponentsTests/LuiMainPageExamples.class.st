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
	| mainPageComponent headerComponent titleComponent navBarComponent navigationComponent applicationAreaComponent |
	mainPageComponent := LuiMainPage named: 'mainPage'.
	
	self assert: (mainPageComponent isKindOf: LuiMainPage).
	self assert: mainPageComponent parentComponent isNil.

	headerComponent := mainPageComponent headerComponent.
	self assert: (mainPageComponent headerComponent isKindOf: LuiPageHeader).
	self assert: headerComponent parentComponent equals: mainPageComponent.
		
	titleComponent := headerComponent pageTitleComponent.
	titleComponent domainObject: 'LCS Example'.
	self assert: titleComponent domainObject equals: 'LCS Example'.
	self assert: (titleComponent isKindOf: LuiPageTitle).
	self assert: titleComponent parentComponent equals: headerComponent.

	navBarComponent := mainPageComponent navBarComponent.
	self assert: (navBarComponent isKindOf: LuiNavigationBar).
	self assert: navBarComponent parentComponent equals: mainPageComponent.
	
	navigationComponent := navBarComponent navigationComponent.
	self assert: navigationComponent parentComponent equals: navBarComponent.
	self assert: (navigationComponent isKindOf: LuiNavigationMenu).

	applicationAreaComponent := mainPageComponent applicationAreaComponent.
	self assert: applicationAreaComponent parentComponent equals: mainPageComponent.
	self assert: (applicationAreaComponent isKindOf: LuiHomeArea).

	^ mainPageComponent
]
