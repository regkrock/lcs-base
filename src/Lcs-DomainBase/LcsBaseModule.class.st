Class {
	#name : #LcsBaseModule,
	#superclass : #LcsDomainObject,
	#instVars : [
		'modules',
		'domainCollections'
	],
	#category : #'Lcs-DomainBase'
}

{ #category : #accessing }
LcsBaseModule class >> moduleName [
	^self class name
]

{ #category : #ini }
LcsBaseModule >> buildModule: eachModuleClass [ 
	self modules buildModuleFor: eachModuleClass
]

{ #category : #ini }
LcsBaseModule >> buildModules [
	self moduleClasses do: [ :eachModuleClass | self buildModule: eachModuleClass ]
]

{ #category : #accessing }
LcsBaseModule >> domainCollections [
	^ domainCollections
]

{ #category : #accessing }
LcsBaseModule >> domainCollections: anObject [
	domainCollections := anObject
]

{ #category : #'modules\t' }
LcsBaseModule >> geographyModule [

	^self modules at: 'Geography Module'
]

{ #category : #testing }
LcsBaseModule >> hasModules [
	^self modules hasElements
]

{ #category : #'testing\t' }
LcsBaseModule >> hasNoModules [
	^self modules hasNoElements
]

{ #category : #accessing }
LcsBaseModule >> initialize [
	super initialize.
	self initializeModules.
	self initializeDomainCollections
]

{ #category : #accessing }
LcsBaseModule >> initializeDomainCollections [
	self domainCollections: (
			LcsDomainCollections new
				parent: self;
				yourself)
]

{ #category : #accessing }
LcsBaseModule >> initializeModules [
	self modules:(
			LcsModules new
				parent: self;
				yourself)
]

{ #category : #'modules\t' }
LcsBaseModule >> legalEntitiesModule [

	^self modules at: 'Legal Entities Module'
]

{ #category : #'configuration\t' }
LcsBaseModule >> moduleClasses [
	^OrderedCollection new
]

{ #category : #accessing }
LcsBaseModule >> moduleName [
	^self class moduleName
]

{ #category : #modules }
LcsBaseModule >> moduleNamed: aString [
	self moduleName = aString ifTrue: [^self].
	^self modules moduleNamed: aString
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
LcsBaseModule >> parent [
	^ parent
]

{ #category : #accessing }
LcsBaseModule >> parent: anObject [
	parent := anObject
]
