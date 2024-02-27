Class {
	#name : #LcsBaseModule,
	#superclass : #LcsObject,
	#instVars : [
		'modules',
		'parent',
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

{ #category : #accessing }
LcsBaseModule >> geographyModule [

	^self modules at: 'Geography'
]

{ #category : #accessing }
LcsBaseModule >> hasModules [
	^self modules hasElements
]

{ #category : #accessing }
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
	self
		modules: (#LcsModules asClass new
				parent: self;
				yourself)
]

{ #category : #accessing }
LcsBaseModule >> moduleClasses [
	^OrderedCollection new
]

{ #category : #accessing }
LcsBaseModule >> moduleName [
	^self class moduleName
]

{ #category : #accessing }
LcsBaseModule >> moduleNamed: aString [
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
