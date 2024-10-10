Class {
	#name : #LuiAllFunctionalTests,
	#superclass : #WAComponent,
	#instVars : [
		'classes',
		'current'
	],
	#category : #'Lcs-WebComponentsTests-Functional'
}

{ #category : #testing }
LuiAllFunctionalTests class >> canBeRoot [
	^ true
]

{ #category : #accessing }
LuiAllFunctionalTests class >> description [
	^ 'Lcs Seaside Functional Test Suite'
]

{ #category : #initialization }
LuiAllFunctionalTests class >> initialize [
	(WAAdmin register: self asApplicationAt: 'lcstests/functional')
		sessionClass: WAExpirySession
]

{ #category : #hooks }
LuiAllFunctionalTests >> children [
	^ Array with: current contents
]

{ #category : #hooks }
LuiAllFunctionalTests >> initialRequest: aRequest [ 
	super initialRequest: aRequest.
	self requestContext consumer nextIfPresentDo: [ :className | 
		classes do: [ :each | 
			"#greaseString is required because of Symbol <-> String comparison"
			each name greaseString = className ifTrue: [ self selected: each ] ] ]
]

{ #category : #initialization }
LuiAllFunctionalTests >> initialize [
	super initialize.
	self initializeTests
]

{ #category : #initialization }
LuiAllFunctionalTests >> initializeTests [
	classes := (WAPresenter allSubclasses select: [ :each | each isLcsFunctionalTest ])
				asSortedCollection: [ :a :b | a name < b name ].
	current := WAValueHolder with: classes first new
]

{ #category : #actions }
LuiAllFunctionalTests >> next [
	| nextIndex |
	nextIndex := self selectionIndex \\ classes size + 1.
	self selected: (classes at: nextIndex)
]

{ #category : #actions }
LuiAllFunctionalTests >> previous [
	| nextIndex |
	nextIndex := (self selectionIndex + classes size - 2 \\ classes size) + 1.
	self selected: (classes at: nextIndex)
]

{ #category : #rendering }
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
			html text: ' '; submitButton: 'Restart' ] ].
	html horizontalRule
			style: 'height: 10px; margin-top: 5px;'.
	html render: current contents
]

{ #category : #accessing }
LuiAllFunctionalTests >> selected [
	^ current contents class
]

{ #category : #accessing }
LuiAllFunctionalTests >> selected: aClass [
	current contents: aClass new.
	(current contents respondsTo: #parent:)
		ifTrue: [ current contents parent: self ]
]

{ #category : #private }
LuiAllFunctionalTests >> selectionIndex [
	^ classes indexOf: self selected
]

{ #category : #hooks }
LuiAllFunctionalTests >> states [
	^ Array with: current
]

{ #category : #updating }
LuiAllFunctionalTests >> updateUrl: aUrl [
	super updateUrl: aUrl.
	"class name is a Symbol, using a String makes a big difference for WALotsaLinksFunctionalTest"
	aUrl addToPath: self selected name greaseString
]
