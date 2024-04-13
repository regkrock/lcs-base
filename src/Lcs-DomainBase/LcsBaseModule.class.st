"
This application is composed of a System and zero to many mdoules. This is the super class of all system and module classes.
"
Class {
	#name : #LcsBaseModule,
	#superclass : #LcsDomainObject,
	#instVars : [
		'modules',
		'domainCollections',
		'configuration'
	],
	#category : #'Lcs-DomainBase'
}

{ #category : #modules }
LcsBaseModule class >> addModuleClassesTo: moduleClasses [ 
	moduleClasses add: self.
	self moduleClasses do: [ :each |
		each addModuleClassesTo: moduleClasses ]
]

{ #category : #'slot definitions' }
LcsBaseModule class >> configurationSlotDefinition [
	<slotDefinition>
	^ LcsModuleConfigurationSlot newOn: LcsBaseConfiguration
]

{ #category : #modules }
LcsBaseModule class >> moduleClasses [
	^ OrderedCollection new
]

{ #category : #configuration }
LcsBaseModule class >> moduleName [
	^ self name
]

{ #category : #building }
LcsBaseModule >> buildModule: eachModuleClass [ 
	self modules buildModuleFor: eachModuleClass
]

{ #category : #building }
LcsBaseModule >> buildModules [
	self moduleClasses do: [ :eachModuleClass | self buildModule: eachModuleClass ]
]

{ #category : #accessing }
LcsBaseModule >> configuration [
	^ self getValueOfSlotNamed: 'configuration'
]

{ #category : #accessing }
LcsBaseModule >> configuration: anObject [
	self setValueOfSlotNamed: 'configuration' to: anObject
]

{ #category : #accessing }
LcsBaseModule >> domainCollections [
	^ domainCollections
]

{ #category : #accessing }
LcsBaseModule >> domainCollections: anObject [
	domainCollections := anObject
]

{ #category : #modules }
LcsBaseModule >> geographyModule [

	^ self moduleNamed: 'Geography Module'
]

{ #category : #'gt views' }
LcsBaseModule >> gtApplicationModulesFor: aView [
	<gtView>
	(self modules isNil or: [ self modules isEmpty ])
		ifTrue: [ 
			^ aView list
				title: 'Modules';
				priority: 1;
				items: #('Has no submodules');
				yourself ].
	^ aView forward
		title: 'Modules';
		priority: 1;
		object: [ self modules ];
		view: #gtApplicationModulesFor:;
		yourself
]

{ #category : #testing }
LcsBaseModule >> hasModules [
	^ self modules hasElements
]

{ #category : #testing }
LcsBaseModule >> hasNoModules [
	^ self modules hasNoElements
]

{ #category : #initialize }
LcsBaseModule >> initialize [
	super initialize.
	self initializeModules.
	self initializeDomainCollections.
]

{ #category : #initialize }
LcsBaseModule >> initializeDomainCollections [
	self domainCollections: (LcsDomainCollections new
				parent: self;
				yourself)
]

{ #category : #initialize }
LcsBaseModule >> initializeModel [
	self slotModel initializeModel: self.
	self modules initializeModel
]

{ #category : #initialize }
LcsBaseModule >> initializeModules [
	self modules:(LcsModules new
						parent: self;
						yourself)
]

{ #category : #modules }
LcsBaseModule >> legalEntitiesModule [

	^ self moduleNamed: 'Legal Entities Module'
]

{ #category : #modu }
LcsBaseModule >> moduleClasses [
	^ self class moduleClasses
]

{ #category : #configuration }
LcsBaseModule >> moduleName [
	^ self class moduleName
]

{ #category : #modules }
LcsBaseModule >> moduleNamed: aString [
	| foundModule |
	self moduleName = aString ifTrue: [ ^ self ].
	foundModule := self modules findModuleNamed: aString.
	foundModule
		ifNil: [ LcsModuleNotFoundError signal: 'Module not found: ' , aString asString ]
		ifNotNil: [ ^ foundModule ]
]

{ #category : #modules }
LcsBaseModule >> moduleViewChildren [
	^ self modules moduleViewChildren
]

{ #category : #accessing }
LcsBaseModule >> modules [
	^ modules
]

{ #category : #accessing }
LcsBaseModule >> modules: anObject [
	modules := anObject
]

{ #category : #modules }
LcsBaseModule >> modulesDo: aBlock [ 
	self modules do: aBlock
]

{ #category : #modules }
LcsBaseModule >> numberOfChildModules [
	^ self modules numberOfModules
]
