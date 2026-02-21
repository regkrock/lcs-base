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
	| associationModel priorAssociations associationWithSameEndpoints fromModel toModel|
	aFromClass isNil ifTrue: [ ^ self ].
	self assert: (fromModel := self modelFor: aFromClass) notNil.
	self assert: (toModel := self modelFor: aToClass) notNil.

	priorAssociations := fromModel associations reverse copy.
	associationModel := fromModel addAssociation: aString toModelNamed: toModel.
	associationWithSameEndpoints := priorAssociations 
		detect: [ :each | each toClassModel = associationModel toClassModel]  
		ifNone: [ ^ self ].
	associationModel factor: associationWithSameEndpoints factor + 0.6
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
LcsUmlModel >> addClassNamed: aClassOrClassname [
	aClassOrClassname isNil ifTrue: [ ^ self ].
	aClassOrClassname isClass ifTrue: [ ^ self addClassModelForExisting: aClassOrClassname ].
	^ ([ aClassOrClassname asClass ] on: NotFound do: [ :s | s return: nil ])
		ifNil: [ self proposedClassModelFor: aClassOrClassname ]
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

{ #category : 'gt view' }
LcsUmlModel >> gtItemsFor: aView [
	<gtView>
	self collection isNil ifTrue: [ ^ aView empty ].
	^ aView columnedTree
		title: 'Items' translated;
		priority: 0.5;
		items: [ self collection ];
		children: [ :each | (each class = LcsAssociationModel) ifTrue: [ #() ] ifFalse: [  each associations ] ];
		column: 'From Class' text: [ :each | (each class = LcsAssociationModel) ifTrue: [ '' ] ifFalse: [ each ]  ];
		column: 'Association' text: [ :each | (each class = LcsAssociationModel) ifTrue: [ each associationName] ifFalse: [ '']  ];
		column: 'To Class' text: [ :each | (each class = LcsAssociationModel) ifTrue: [ each toClassModel ] ifFalse: [ '']  ];
		actionUpdateButton
]

{ #category : 'testing' }
LcsUmlModel >> hasModelFor: aStringOrClass [
	^ (self modelFor: aStringOrClass) notNil
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

{ #category : 'testing' }
LcsUmlModel >> modelFor: aStringOrClass [
	^ self
		detect: [ :each | each modelClassname = aStringOrClass or: [ each modelClass = aStringOrClass ] ]
		ifNone: [ nil ]
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
