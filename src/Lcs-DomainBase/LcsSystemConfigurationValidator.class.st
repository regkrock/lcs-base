Class {
	#name : #LcsSystemConfigurationValidator,
	#superclass : #LcsValidator,
	#category : #'Lcs-DomainBase'
}

{ #category : #'validation\t' }
LcsSystemConfigurationValidator >> validateCurrentObject [
	self objectBeingValidated addValidateConfigurationResultTo: self
]
