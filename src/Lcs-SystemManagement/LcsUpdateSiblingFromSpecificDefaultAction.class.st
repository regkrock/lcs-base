Class {
	#name : #LcsUpdateSiblingFromSpecificDefaultAction,
	#superclass : #LcsUpdateAction,
	#instVars : [
		'siblingSlotName',
		'sourceSlotName'
	],
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #defaults }
LcsUpdateSiblingFromSpecificDefaultAction >> defaultActionBlock [
	^ [ :newValue :domainObject :oldValue | 
			domainObject 
				perform: (self siblingSlotName , ':') asSymbol 
				with: (newValue perform: self sourceSlotName asSymbol) ]
]

{ #category : #accessing }
LcsUpdateSiblingFromSpecificDefaultAction >> siblingSlotName [
	^ siblingSlotName
]

{ #category : #accessing }
LcsUpdateSiblingFromSpecificDefaultAction >> siblingSlotName: aSlotName [
	siblingSlotName := aSlotName
]

{ #category : #accessing }
LcsUpdateSiblingFromSpecificDefaultAction >> sourceSlotName [
	^ sourceSlotName
]

{ #category : #accessing }
LcsUpdateSiblingFromSpecificDefaultAction >> sourceSlotName: aString [
	sourceSlotName := aString
]
