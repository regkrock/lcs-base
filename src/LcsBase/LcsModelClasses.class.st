Class {
	#name : #LcsModelClasses,
	#superclass : #LcsObject,
	#traits : 'LtOrderedCollection',
	#classTraits : 'LtOrderedCollection classTrait',
	#category : #'LcsBase-Core'
}

{ #category : #configuration }
LcsModelClasses >> connectHierarchy [
	| modelSuperclass |
	self collection copy do: [ :each |
		modelSuperclass := self collection detect: [ :potentialSuperclassModel |
			potentialSuperclassModel isModelSuperclassOf: each ] ifNone: [].
		modelSuperclass ifNotNil: [
			each modelSuperclass: modelSuperclass ]]
]
