Class {
	#name : #LcsClassesModel,
	#superclass : #LcsObject,
	#traits : 'LtOrderedCollection',
	#classTraits : 'LtOrderedCollection classTrait',
	#category : #'LcsBase-Core'
}

{ #category : #model }
LcsClassesModel >> addClassModel: aClassModel [
	^ (self classModelForClassname: aClassModel modelClassname asString)
		ifNil: [ 
			Transcript tab.
			self traceCr: 'Adding class ' , aClassModel printString.
			self add: aClassModel]
		ifNotNil: [ :model | model ]
]

{ #category : #configuration }
LcsClassesModel >> addClassNamed: aClassname [
	aClassname isNil ifTrue: [ ^ self ].
	([ aClassname asString asClass ] on: NotFound do: [ :s | s return: nil ])
		ifNil: [ self proposedClassModelFor: aClassname ]
		ifNotNil: [ :class | self existingClassModelFor: class ]
]

{ #category : #model }
LcsClassesModel >> allClassModelsFor: aClassname [
	^ self collection select: [ :eachModel | eachModel modelClassname = aClassname asString ]
]

{ #category : #configuration }
LcsClassesModel >> classModelForClassname: aClassname [
	^ self collection 
		detect: [ :eachModel | eachModel modelClassname = aClassname asString ]
		ifNone: [  
			"Transcript cr; show: 'Unable to find class named ' , aClassname asString."
			nil  ] 
]

{ #category : #model }
LcsClassesModel >> existingClassModelFor: aClass [
	^ self addClassModel: (LcsExistingClassModel newOn: aClass)
]

{ #category : #model }
LcsClassesModel >> proposedClassModelFor: aClassname [
	^ self addClassModel: (LcsProposedClassModel newOn: aClassname)
]

{ #category : #configuration }
LcsClassesModel >> resolveClassModelNames [
	self traceCr: 'Resolving super class names '.
	self collection do: [ :eachClassModel | self resolveSuperclassFor: eachClassModel ].
	self traceCr: 'Resolving to association class names '.
	self collection do: [ :eachClassModel | self resolveToClassModelAssociationFor: eachClassModel ]
]

{ #category : #configuration }
LcsClassesModel >> resolveSuperclassFor: aClassModel [
	aClassModel modelSuperclass: (
		self collection
			detect: [ :potentialSuperclassModel | potentialSuperclassModel isModelSuperclassOf: aClassModel ]
			ifNone: [ 
				Transcript tab. 
				self traceCr: 'Unable to find class named ' , aClassModel modelSuperclassName asString.
				nil ])
]

{ #category : #configuration }
LcsClassesModel >> resolveToClassModelAssociationFor: eachClassModel [
	eachClassModel associations do: [ :eachAssociation | 
		eachAssociation toClassModel isNil ifTrue: [ 
			eachAssociation toClassModel: (self classModelForClassname: eachAssociation toClassModelName) ] ]
]
