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
		ifNil: [ self add: aClassModel]
		ifNotNil: [ :model | model ]
]

{ #category : #model }
LcsClassesModel >> allClassModelsFor: aClassname [
	^ self collection select: [ :eachModel | eachModel modelClassname = aClassname asString ]
]

{ #category : #configuration }
LcsClassesModel >> classModelForClassname: aClassname [
	^ self collection 
		detect: [ :eachModel | eachModel modelClassname = aClassname asString ]
		ifNone: [ ] 
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
	self collection do: [ :eachClassModel | self resolveSuperclassFor: eachClassModel ].
	self collection do: [ :eachClassModel | self resolveToClassModelAssociationFor: eachClassModel ]
]

{ #category : #configuration }
LcsClassesModel >> resolveSuperclassFor: aClassModel [
	aClassModel modelSuperclass: (
		self collection
			detect: [ :potentialSuperclassModel | potentialSuperclassModel isModelSuperclassOf: aClassModel ]
			ifNone: [  ])
]

{ #category : #configuration }
LcsClassesModel >> resolveToClassModelAssociationFor: eachClassModel [
	eachClassModel associations do: [ :eachAssociation | 
		eachAssociation toClassModel isNil ifTrue: [ 
			eachAssociation toClassModel: (self classModelForClassname: eachAssociation toClassModelName) ] ]
]
