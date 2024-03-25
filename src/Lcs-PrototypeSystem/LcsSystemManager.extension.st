Extension { #name : #LcsSystemManager }

{ #category : #'*Lcs-PrototypeSystem' }
LcsSystemManager class >> createPrototypeSystem [
	self currentSystem: #LxxPrototypeSystem asClass newSystem
]
