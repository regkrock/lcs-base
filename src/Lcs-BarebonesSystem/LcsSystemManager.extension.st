Extension { #name : #LcsSystemManager }

{ #category : #'*Lcs-BarebonesSystem' }
LcsSystemManager class >> createBarebonesSystem [
	self currentSystem: #LxxBarebonesSystem asClass newSystem
]
