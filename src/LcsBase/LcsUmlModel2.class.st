Class {
	#name : #LcsUmlModel2,
	#superclass : #LcsObject,
	#traits : 'LtOrderedCollection',
	#classTraits : 'LtOrderedCollection classTrait',
	#category : #'LcsBase-Core'
}

{ #category : #'instance creation' }
LcsUmlModel2 class >> new [ 
	^ super new
]

{ #category : #model }
LcsUmlModel2 >> addClassModel: aClassModel [
	^ (self classModelForClassname: aClassModel modelClassname asString)
		ifNil: [ 
			Transcript tab.
			self traceCr: 'Adding class ' , aClassModel printString.
			self add: aClassModel]
		ifNotNil: [ :model | model ]
]

{ #category : #configuration }
LcsUmlModel2 >> addClassNamed: aClassname [
	aClassname isNil ifTrue: [ ^ self ].
	([ aClassname asString asClass ] on: NotFound do: [ :s | s return: nil ])
		ifNil: [ self proposedClassModelFor: aClassname ]
		ifNotNil: [ :class | self existingClassModelFor: class ]
]

{ #category : #model }
LcsUmlModel2 >> allClassModelsFor: aClassname [
	^ self collection select: [ :eachModel | eachModel modelClassname = aClassname asString ]
]

{ #category : #configuration }
LcsUmlModel2 >> classModelForClassname: aClassname [
	^ self collection 
		detect: [ :eachModel | eachModel modelClassname = aClassname asString ]
		ifNone: [  
			"Transcript cr; show: 'Unable to find class named ' , aClassname asString."
			nil  ] 
]

{ #category : #model }
LcsUmlModel2 >> existingClassModelFor: aClass [
	^ self addClassModel: (LcsExistingClassModel newOn: aClass)
]

{ #category : #model }
LcsUmlModel2 >> proposedClassModelFor: aClassname [
	^ self addClassModel: (LcsProposedClassModel newOn: aClassname)
]

{ #category : #configuration }
LcsUmlModel2 >> resolveClassModelNames [
	self traceCr: 'Resolving super class names '.
	self collection do: [ :eachClassModel | self resolveSuperclassFor: eachClassModel ].
	self traceCr: 'Resolving to association class names '.
	self collection do: [ :eachClassModel | self resolveToClassModelAssociationFor: eachClassModel ]
]

{ #category : #configuration }
LcsUmlModel2 >> resolveSuperclassFor: aClassModel [
	aClassModel modelSuperclass: (
		self collection
			detect: [ :potentialSuperclassModel | potentialSuperclassModel isModelSuperclassOf: aClassModel ]
			ifNone: [ 
				Transcript tab. 
				self traceCr: 'Unable to find class named ' , aClassModel modelSuperclassName asString.
				nil ])
]

{ #category : #configuration }
LcsUmlModel2 >> resolveToClassModelAssociationFor: eachClassModel [
	eachClassModel associations do: [ :eachAssociation | 
		eachAssociation toClassModel isNil ifTrue: [ 
			eachAssociation toClassModel: (self classModelForClassname: eachAssociation toClassModelName) ] ]
]
