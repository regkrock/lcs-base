Class {
	#name : 'LuiExperimentRoot',
	#superclass : 'LuiApplicationRoot',
	#instVars : [
		'numtoconvert',
		'result'
	],
	#category : 'Lcs-WebComponentsTests-Experiment',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Experiment'
}

{ #category : 'initialize' }
LuiExperimentRoot class >> initialize [
	self registerApplication: 'lcsExperiment'
]

{ #category : 'updating' }
LuiExperimentRoot >> applicationTitle [
	^ self class name greaseString
]

{ #category : 'components' }
LuiExperimentRoot >> currentFrom [
	^ self mainForm currentSwitchableComponent
]

{ #category : 'components - updating' }
LuiExperimentRoot >> currentSwitchableComponent [
	^ self mainForm currentSwitchableComponent
]

{ #category : 'initialize' }
LuiExperimentRoot >> initialize [
	"Re-implment this method with desired components"
	super initialize.
	LuiExampleCompanyPageLayoutTemplate new buildLayoutFor: self
]

{ #category : 'components' }
LuiExperimentRoot >> mainForm [
	^ self componentNamed: 'mainForm'
]

{ #category : 'components' }
LuiExperimentRoot >> pageHeader [
	^ self componentNamed: 'pageHeader'
]

{ #category : 'components' }
LuiExperimentRoot >> pageHeaderComponentDefinition [
	^ (LuiPageHeader new)
		addComponent: LuiMenuExamples new softwareCompanyNavigationBar;
		yourself
]

{ #category : 'components - updating' }
LuiExperimentRoot >> switchMainComponentTo: aComponent [
	self mainForm switchToComponent: aComponent
]

{ #category : 'updating' }
LuiExperimentRoot >> updateFilesInRoot: anHtmlRoot [ 
	| fileClass |
	fileClass := LcsExperimentFileLibrary.
	super updateFilesInRoot: anHtmlRoot.
	anHtmlRoot stylesheet url: fileClass / #resetCss.
	anHtmlRoot stylesheet url: fileClass / #mainCss.
	anHtmlRoot link beShortcutIcon url: fileClass / #faviconPng
]
