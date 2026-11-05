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
LuiExperimentRoot >> experimentalComponent [
	"Re-implment this method with desired components"
	^ LuiMenuExamples new softwareCompanyNavbar
]

{ #category : 'initialize' }
LuiExperimentRoot >> initialize [
	super initialize.
	self addComponent: self experimentalComponent.
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
