Class {
	#name : 'LcsUmlModel',
	#superclass : 'LcsObject',
	#traits : 'LtOrderedCollection',
	#classTraits : 'LtOrderedCollection classTrait',
	#instVars : [
		'layoutPolicy'
	],
	#category : 'LcsBase-Core',
	#package : 'LcsBase',
	#tag : 'Core'
}

{ #category : 'instance creation' }
LcsUmlModel class >> new [ 
	^ super new
]

{ #category : 'configuration' }
LcsUmlModel >> addAssociation: aString from: aFromClass to: aToClass [
	self assert: (self hasModelFor: aFromClass).
	self assert: (self hasModelFor: aToClass).
	(self classModelForClassname: aFromClass)
		addAssociation: aString toModelNamed: aToClass.
]

{ #category : 'configuration' }
LcsUmlModel >> addClass: aClass [
	aClass isNil ifTrue: [ ^ self ].
	aClass isClass ifFalse: [ ^ self ].
	self addClassModelForExisting: aClass 
]

{ #category : 'model' }
LcsUmlModel >> addClassModel: aClassModel [
	| model |
	model := self classModelForClassname: aClassModel modelClassname asString.
	model := model ifNil: [ self add: aClassModel ].
	^ model
]

{ #category : 'model' }
LcsUmlModel >> addClassModelForExisting: aClass [
	^ self addClassModel: (LcsExistingClassModel newOn: aClass)
]

{ #category : 'configuration' }
LcsUmlModel >> addClassNamed: aClassname [
	aClassname isNil ifTrue: [ ^ self ].
	([ aClassname asString asClass ] on: NotFound do: [ :s | s return: nil ])
		ifNil: [ self proposedClassModelFor: aClassname ]
		ifNotNil: [ :class | self addClassModelForExisting: class ]
]

{ #category : 'model' }
LcsUmlModel >> allClassModelsFor: aClassname [
	^ self collection select: [ :eachModel | eachModel modelClassname = aClassname asString ]
]

{ #category : 'api' }
LcsUmlModel >> applyLayoutTo: mondrianModel [
	self layoutPolicy applyLayoutTo: mondrianModel
]

{ #category : 'configuration' }
LcsUmlModel >> classModelForClass: aClass [
	^ self collection 
		detect: [ :eachModel | eachModel isModelOf: aClass ]
		ifNone: [  
			"Transcript cr; show: 'Unable to find class named ' , aClassname asString."
			nil  ] 
]

{ #category : 'configuration' }
LcsUmlModel >> classModelForClassname: aClassname [
	^ self collection 
		detect: [ :eachModel | eachModel modelClassname = aClassname asString ]
		ifNone: [  
			"Transcript cr; show: 'Unable to find class named ' , aClassname asString."
			nil  ] 
]

{ #category : 'testing' }
LcsUmlModel >> hasModelFor: aStringOrClass [
	self
		detect: [ :each | each modelClassname = aStringOrClass or: [ each modelClass = aStringOrClass ] ]
		ifNone: [ ^ false ].
	^ true
]

{ #category : 'initialize\t' }
LcsUmlModel >> initialize [ 
	super initialize.
	self collection: self collectionClass new.
	self positions: OrderedCollection new.
	self layoutPolicy: LcsUmlMondrianTreeLayoutPolicy new
]

{ #category : 'accessing' }
LcsUmlModel >> layoutPolicy [
	^ layoutPolicy
]

{ #category : 'accessing' }
LcsUmlModel >> layoutPolicy: anObject [
	layoutPolicy := anObject
]

{ #category : 'accessing' }
LcsUmlModel >> positions: aCollection [
	aCollection isEmpty ifTrue: [ ^ self ].
	self layoutPolicy: (LcsUmlMondrianCustomLayoutPolicy new
							positions: aCollection;
							yourself)
]

{ #category : 'model' }
LcsUmlModel >> proposedClassModelFor: aClassname [
	^ self addClassModel: (LcsProposedClassModel newOn: aClassname)
]

{ #category : 'configuration' }
LcsUmlModel >> resolveClassModelNames [
	LcsBuilderLogger log:  'Resolving super class names '.
	self collection do: [ :eachClassModel | self resolveSuperclassFor: eachClassModel ].
	LcsBuilderLogger log:  'Resolving to association class names '.
	self collection do: [ :eachClassModel | self resolveToClassModelAssociationFor: eachClassModel ]
]

{ #category : 'configuration' }
LcsUmlModel >> resolveSuperclassFor: aClassModel [
	aClassModel modelSuperclass: (
		self collection
			detect: [ :potentialSuperclassModel | potentialSuperclassModel isModelSuperclassOf: aClassModel ]
			ifNone: [ 
				LcsBuilderLogger logTab: 'Unable to find class named ' , aClassModel modelSuperclassName asString.
				nil ])
]

{ #category : 'configuration' }
LcsUmlModel >> resolveToClassModelAssociationFor: aClassModel [
	aClassModel associations do: [ :eachAssociation | 
		eachAssociation toClassModel isNil ifTrue: [ 
			eachAssociation toClassModel: (self classModelForClassname: eachAssociation toClassModelName) ] ]
]
