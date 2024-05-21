Class {
	#name : #LcsCodeCollectionClassBuilder,
	#superclass : #LcsBaseCodeClassBuilder,
	#category : #'Lcs-Tools'
}

{ #category : #accessing }
LcsCodeCollectionClassBuilder class >> superclassName [
	^ 'LcsCodes'
]

{ #category : #accessing }
LcsCodeCollectionClassBuilder >> updateSlotModel [
	super updateSlotModel
]

{ #category : #accessing }
LcsCodeCollectionClassBuilder >> verifyInstallation [
	super verifyInstallation.
	self assert: self installedClass superclass name equals: 'LcsCodes'
]
