# Continuous Delivery Pipeline

!SUB
- Code
- Build
- Test
- Deploy


!SUB
# Code
- Develop
- Commit
- Post-commit hook triggers new "delivery"


!SUB
# Build
- Get sources
- Compile sources


!SUB
# Test
- Test


!SUB
# Deploy
- Deploy

!SLIDE
# Continuous Delivery
with
# Docker


!SUB
# Code
- Develop
- Commit
- Post-commit hook triggers new "delivery"


!SUB
# Build
- Get sources
- Compile sources in `builder` container


!SUB
# Test
- Run tests from `tester` container


!SUB
# Deploy
- Push the image to the Docker registry
