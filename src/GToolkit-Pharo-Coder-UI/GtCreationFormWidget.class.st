Class {
	#name : #GtCreationFormWidget,
	#superclass : #BrFrame,
	#traits : 'TBrLayoutResizable',
	#classTraits : 'TBrLayoutResizable classTrait',
	#instVars : [
		'onAccept',
		'form'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Forms'
}

{ #category : #'instance creation' }
GtCreationFormWidget class >> forBaseline [
	^ self forForm: GtBaselineCreationForm new
]

{ #category : #'instance creation' }
GtCreationFormWidget class >> forClass [
	^ self forForm: GtClassCreationForm new
]

{ #category : #'instance creation' }
GtCreationFormWidget class >> forForm: arg1 [
	^ self new form: arg1
]

{ #category : #'instance creation' }
GtCreationFormWidget class >> forPackage [
	^ self forForm: GtPackageCreationForm new
]

{ #category : #'instance creation' }
GtCreationFormWidget class >> forParser [
	^ self forForm: GtParserCreationForm new
]

{ #category : #'instance creation' }
GtCreationFormWidget class >> forTrait [
	^ self forForm: GtTraitCreationForm new
]

{ #category : #converting }
GtCreationFormWidget >> createForm [
	self addChild: (self form onAccept: self onAccept) asElement
]

{ #category : #accessing }
GtCreationFormWidget >> form [
	^ form
]

{ #category : #accessing }
GtCreationFormWidget >> form: arg1 [
	form := arg1.
	self
		removeChildren;
		createForm
]

{ #category : #initialization }
GtCreationFormWidget >> initialize [
	super initialize.
	onAccept := [ :arg1 | self phlow spawnObject: arg1 ].
	self
		layout: BlFlowLayout vertical;
		margin: (BlInsets all: 5);
		constraintsDo: [ :arg2 | 
				arg2 horizontal exact: 400.
				arg2 vertical fitContent ]
]

{ #category : #accessing }
GtCreationFormWidget >> onAccept [
	^ onAccept
]

{ #category : #accessing }
GtCreationFormWidget >> onAccept: arg1 [
	onAccept := arg1.
	self
		removeChildren;
		createForm
]
