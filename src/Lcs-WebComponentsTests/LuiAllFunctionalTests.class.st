Class {
	#name : 'LuiAllFunctionalTests',
	#superclass : 'WAComponent',
	#instVars : [
		'classes',
		'current',
		'activeFunctionalTests'
	],
	#category : 'Lcs-WebComponentsTests-Functional',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Functional'
}

{ #category : 'testing' }
LuiAllFunctionalTests class >> canBeRoot [
	^ true
]

{ #category : 'accessing' }
LuiAllFunctionalTests class >> description [
	^ 'Lcs Seaside Functional Test Suite'
]

{ #category : 'initialization' }
LuiAllFunctionalTests class >> initialize [
	(WAAdmin register: self asApplicationAt: 'lcstests/functional')
		sessionClass: WAExpirySession;
		scriptGeneratorClass: JQScriptGenerator;
		addLibrary: JQDeploymentLibrary
]

{ #category : 'accessing' }
LuiAllFunctionalTests >> activeFunctionalTests [
	^ activeFunctionalTests
]

{ #category : 'accessing' }
LuiAllFunctionalTests >> activeFunctionalTests: anObject [
	activeFunctionalTests := anObject
]

{ #category : 'hooks' }
LuiAllFunctionalTests >> children [
	^ Array with: current contents
]

{ #category : 'accessing' }
LuiAllFunctionalTests >> functionalTestContextFor: aClass [ 
	| functionalTest context|
	functionalTest := aClass new.
	context := LuiFunctionalTestContext newTest: functionalTest unitOfWork: LcsApplicationEnvironment currentUnitOfWork.
	^ context
	
]

{ #category : 'hooks' }
LuiAllFunctionalTests >> initialRequest: aRequest [ 
	super initialRequest: aRequest.
	self requestContext consumer nextIfPresentDo: [ :className | 
		classes do: [ :each | 
			"#greaseString is required because of Symbol <-> String comparison"
			each name greaseString = className ifTrue: [ self selected: each ] ] ]
]

{ #category : 'initialization' }
LuiAllFunctionalTests >> initialize [
	super initialize.
	self activeFunctionalTests: Dictionary new.
	self initializeTests
]

{ #category : 'initialization' }
LuiAllFunctionalTests >> initializeTests [
	classes := (LuiFunctionalTest allSubclasses select: [ :each | each isLcsFunctionalTest ])
				asSortedCollection: [ :a :b | a name < b name ].
	current := WAValueHolder with: classes first new
]

{ #category : 'actions' }
LuiAllFunctionalTests >> next [
	| nextIndex |
	nextIndex := self selectionIndex \\ classes size + 1.
	self selected: (classes at: nextIndex)
]

{ #category : 'actions' }
LuiAllFunctionalTests >> previous [
	| nextIndex |
	nextIndex := (self selectionIndex + classes size - 2 \\ classes size) + 1.
	self selected: (classes at: nextIndex)
]

{ #category : 'rendering' }
LuiAllFunctionalTests >> renderContentOn: html [
	html heading: self class description.
	html form: [
		html paragraph: [
			html anchor
				callback: [ self previous ];
				with: [ html html: '&larr;' ].
			html select
				list: classes;
				onChange: 'submit()';
				selected: self selected;
				labels: [ :value | value name ];
				callback: [ :value | self selected: value ].
			html anchor
				callback: [ self next ];
				with: [ html html: '&rarr;' ].
			html text: ' '.
			html submitButton 
				callback: [ self restart ];
				with: 'Restart' ] ].
	html horizontalRule
			style: 'height: 10px; margin-top: 5px;'.
	html render: current contents
]

{ #category : 'rendering' }
LuiAllFunctionalTests >> restart [
	"Restart is only available for the current form. So it is okay to clear the unit of
	work as the system and unit of work are not changing for the new instance of the form.
	
	If there was a separate unit of work for each form in the same system, then a separate unit
	of work needs to be implemented for each form."
	| newFunctionalTest |
	self activeFunctionalTests at: self selected ifPresent: [ :context | context clearUnitOfWork ].
	newFunctionalTest := self functionalTestContextFor: self selected.
	self activeFunctionalTests at: self selected put: newFunctionalTest.
	self setCurrentContents: newFunctionalTest
]

{ #category : 'accessing' }
LuiAllFunctionalTests >> selected [
	^ current contents class
]

{ #category : 'accessing' }
LuiAllFunctionalTests >> selected: aClass [
	| functionalTestContext |
	functionalTestContext := self activeFunctionalTests
			at: aClass
			ifAbsentPut: [ self functionalTestContextFor: aClass ].
	self setCurrentContents: functionalTestContext
]

{ #category : 'private' }
LuiAllFunctionalTests >> selectionIndex [
	^ classes indexOf: self selected
]

{ #category : 'accessing' }
LuiAllFunctionalTests >> setCurrentContents: aFunctionalTestContext [
	LcsApplicationEnvironment makeSystemCurrent: aFunctionalTestContext system.
	self assert: aFunctionalTestContext system isInActiveStatus.
	current contents: aFunctionalTestContext functionalTest.
	(current contents respondsTo: #parent:)
		ifTrue: [ current contents parent: self ]
]

{ #category : 'hooks' }
LuiAllFunctionalTests >> states [
	^ Array with: current
]

{ #category : 'updating' }
LuiAllFunctionalTests >> updateRoot: anHtmlRoot [
	super updateRoot: anHtmlRoot.
	anHtmlRoot javascript url: JQDeploymentLibrary.
	"class name is a Symbol, using a String makes a big difference for WALotsaLinksFunctionalTest"
	"aUrl addToPath: self selected name greaseString"
]

{ #category : 'updating' }
LuiAllFunctionalTests >> updateUrl: aUrl [
	super updateUrl: aUrl.
	"class name is a Symbol, using a String makes a big difference for WALotsaLinksFunctionalTest"
	aUrl addToPath: self selected name greaseString
]
