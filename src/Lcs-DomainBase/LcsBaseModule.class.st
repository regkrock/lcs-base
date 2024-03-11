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

{ #category : #accessing }
LcsBaseModule class >> moduleName [
	^ self class name
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

	^ self modules at: 'Geography Module'
]

{ #category : #testing }
LcsBaseModule >> hasModules [
	^ self modules hasElements
]

{ #category : #testing }
LcsBaseModule >> hasNoModules [
	^ self modules hasNoElements
]

{ #category : #initialization }
LcsBaseModule >> initialize [
	super initialize.
	self initializeModules.
	self initializeDomainCollections.
]

{ #category : #initialization }
LcsBaseModule >> initializeDomainCollections [
	self domainCollections: (LcsDomainCollections new
										parent: self;
										yourself)
]

{ #category : #initialization }
LcsBaseModule >> initializeModel [
	self slotDefintions initializeModel: self.
	self modules initializeModel
]

{ #category : #initialization }
LcsBaseModule >> initializeModules [
	self modules:(LcsModules new
						parent: self;
						yourself)
]

{ #category : #modules }
LcsBaseModule >> legalEntitiesModule [

	^ self modules at: 'Legal Entities Module'
]

{ #category : #modules }
LcsBaseModule >> moduleClasses [
	^ OrderedCollection new
]

{ #category : #accessing }
LcsBaseModule >> moduleName [
	^ self class moduleName
]

{ #category : #modules }
LcsBaseModule >> moduleNamed: aString [
	self moduleName = aString ifTrue: [ ^ self ].
	^ self modules moduleNamed: aString
]

{ #category : #accessing }
LcsBaseModule >> modules [
	^ modules
]

{ #category : #accessing }
LcsBaseModule >> modules: anObject [
	modules := anObject
]

{ #category : #accessing }
LcsBaseModule >> modulesDo: aBlock [ 
	self modules contentsDo: aBlock
]

{ #category : #accessing }
LcsBaseModule >> numberOfChildModules [
	^ self modules numberOfModules
]

{ #category : #validation }
LcsBaseModule >> validateConfiguration [
	super validateConfiguration.

	self modulesDo: [ :eachModule | eachModule validateConfiguration	 ]
]
