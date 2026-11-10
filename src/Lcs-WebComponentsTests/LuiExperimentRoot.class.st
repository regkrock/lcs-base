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

{ #category : 'initialize' }
LuiExperimentRoot >> initialize [
	super initialize.
	"Re-implment this method with desired components"
	self addComponent: self pageHeaderComponentDefinition.
	self addComponent: self mainFormComponentDefinition.
]

{ #category : 'components' }
LuiExperimentRoot >> mainForm [
	^ self componentNamed: 'mainForm'
]

{ #category : 'initialize' }
LuiExperimentRoot >> mainFormComponentDefinition [
	^ LuiMainForm new
		switchToComponent: (LuiHomePresenter named: 'homePresenter');
		yourself
]

{ #category : 'components' }
LuiExperimentRoot >> pageHeader [
	^ self componentNamed: 'pageHeader'
]

{ #category : 'components' }
LuiExperimentRoot >> pageHeaderComponentDefinition [
	^ (LuiPageHeader named: 'pageHeader')
		addComponent: LuiMenuExamples new softwareCompanyNavbar;
		yourself
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
